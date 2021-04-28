import QtQuick 2.15
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.15

Item {
    id: calendar

    property alias selectedDate: listView.selectedDate
    property var existingTasks: []
    property var existingTasksByDay: calcExistingTasksByDay()
    property color taskColor: "#ff0000"
    property color selectedTextColor: "#000000"

    onExistingTasksChanged: {
        existingTasksByDay = calcExistingTasksByDay()
    }

    function getDayOfYear(date) {
        return Math.floor((date - new Date(date.getFullYear(), 0, 0)) / 1000 / 60 / 60 / 24) - 1;
    }

    function calcExistingTasksByDay() {
        var array = new Array(366).fill(0)
        existingTasks.forEach(function(item, i, existingTasks) {
            var dayOfYear = getDayOfYear(item.begin)
            array[dayOfYear] = Math.min(4, array[dayOfYear]+1)
        });
        return array
    }

    ListView {
        id: listView
        anchors.fill: parent
        highlightMoveDuration: 100
        highlightMoveVelocity: -1

        property date selectedDate: new Date()

        snapMode: ListView.SnapOneItem
        orientation: Qt.Horizontal
        clip: true

        model: 12
        cacheBuffer: 3

        Component.onCompleted: {
            currentIndex = selectedDate.getMonth()
        }

        delegate: Item {
            width: listView.width
            height: listView.height

            property int year: listView.selectedDate.getFullYear()
            property int month: index % 12
            property int firstDay: new Date(year, month, 1).getDay() - 1

            Column {
                Item {
                    width: listView.width
                    height: 60

                    Text {
                        anchors.centerIn: parent
                        text: [ qsTr("January"), qsTr("February"), qsTr("March"),
                            qsTr("April"), qsTr("May"), qsTr("June"),
                            qsTr("July"), qsTr("August"), qsTr("September"),
                            qsTr("October"), qsTr("November"), qsTr("December")][month]
                        font.pixelSize: 40
                        font.family: "Catamaran"
                    }
                }

                VerticalSpacerItem {
                    height: 20
                }

                Grid {
                    id: grid

                    width: listView.width
                    height: 340
                    columns: 7
                    rows: 7

                    property real cellWidth: width  / columns
                    property real cellHeight: height / rows

                    Repeater {
                        model: grid.columns * grid.rows // 49 cells per month

                        delegate: Rectangle { // index is 0 to 48
                            id: delegateRect
                            width: grid.cellWidth
                            height: grid.cellHeight
                            opacity: !mouseArea.pressed ? 1 : 0.3  //  pressed state

                            property int dayOfWeek: index - 7 // 0 = top left below Sunday (-7 to 41)
                            property int day: dayOfWeek - firstDay + 1 // 1-31
                            property date date: new Date(year, month, day)
                            property bool isSelected: date.toDateString() == listView.selectedDate.toDateString()
                                                      && text.text && dayOfWeek >= 0

                            Item {
                                id: selection
                                anchors.fill: parent
                                anchors.topMargin: 4
                                anchors.bottomMargin: 4
                                anchors.leftMargin: 8
                                anchors.rightMargin: 8

                                Rectangle {
                                    anchors.fill: parent
                                    visible: delegateRect.isSelected
                                    radius: 6
                                    gradient: Gradient {
                                        GradientStop { position: 0.0; color: calendar.taskColor }
                                        GradientStop { position: 1.0; color: Qt.darker(calendar.taskColor, 1.2) }
                                    }
                                }
                            }

                            RowLayout {
                                anchors.bottom: parent.bottom
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.bottomMargin: 10
                                height: 4
                                spacing: 1

                                Repeater {
                                    id: existingTaskRepeater
                                    model: text.text && delegateRect.dayOfWeek >= 0
                                           ? existingTasksByDay[getDayOfYear(delegateRect.date)]
                                           : 0

                                    Rectangle {
                                        Layout.alignment: Qt.AlignCenter
                                        Layout.preferredWidth: 2
                                        Layout.preferredHeight: 2
                                        Layout.fillWidth: false
                                        Layout.fillHeight: false
                                        color: delegateRect.isSelected ? "#ffffff" : "#3D3D3D"
                                    }
                                }
                            }

                            Text {
                                id: text

                                anchors.centerIn: parent
                                font.pixelSize: delegateRect.dayOfWeek < 0 ? 13 : 24
                                font.weight: delegateRect.dayOfWeek < 0 ? Font.Thin : Font.Normal
                                font.family: delegateRect.dayOfWeek < 0 ? "Catamaran Thin" : "Chathura"
                                color: delegateRect.isSelected ? calendar.selectedTextColor : "#000000"
                                text: {
                                    if (delegateRect.dayOfWeek < 0) [ 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun' ][index] // Su-Sa
                                    else if (delegateRect.date.getMonth() === month) delegateRect.day // 1-31
                                    else ''
                                }
                            }

                            MouseArea {
                                id: mouseArea

                                anchors.fill: parent
                                enabled: text.text && delegateRect.dayOfWeek >= 0

                                onClicked: {
                                    listView.selectedDate = delegateRect.date
                                    console.log(listView.selectedDate, "----", year)
                                }
                            }

                            Component.onCompleted: {
                                existingTaskRepeater.model = text.text && delegateRect.dayOfWeek >= 0
                                       ? existingTasksByDay[getDayOfYear(delegateRect.date)]
                                       : 0
                            }
                        }
                    }
                }
            }
        }
    }

    Item {
        width: 32
        height: 32
        anchors.top: parent.top
        anchors.topMargin: 32
        anchors.left: parent.left
        anchors.leftMargin: 64

        Image {
            id: imagePrev
            anchors.centerIn: parent
            source: "qrc:/assets/icons/prev.svg"
        }

        DropShadow {
            id: shadowPrev
            anchors.fill: imagePrev
            source: imagePrev
            radius: 1
            samples: radius * 4
        }

        MouseArea {
            anchors.fill: parent
            onClicked: listView.decrementCurrentIndex()
            onEntered: shadowPrev.radius = 4
            onExited: shadowPrev.radius = 1
        }
    }

    Item {
        width: 32
        height: 32
        anchors.top: parent.top
        anchors.topMargin: 32
        anchors.right: parent.right
        anchors.rightMargin: 64

        Image {
            id: imageNext
            anchors.centerIn: parent
            source: "qrc:/assets/icons/next.svg"
        }

        DropShadow {
            id: shadowNext
            anchors.fill: imageNext
            source: imageNext
            radius: 1
            samples: radius * 4
        }

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onClicked: listView.incrementCurrentIndex()
            onEntered: shadowNext.radius = 4
            onExited: shadowNext.radius = 1
        }
    }
}
