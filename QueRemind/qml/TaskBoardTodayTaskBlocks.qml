import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.2
import QtGraphicalEffects 1.15

Item {
    id: taskBoardTaskBlocks

    property string userName: "anonymous"
    property int sectionWidth: 100
    property int blockHeight: 140
    property date startDate: new Date()

    signal taskBlockClicked(var taskData)
    signal taskBlockDoubleClicked(var taskData)

    function addTask(taskData) {
        var component = Qt.createComponent("TaskBlock.qml")
        var taskBlock = component.createObject(tasksFlickableItem)
        taskBlock.taskData = taskData
        taskBlock.sectionWidth = sectionWidth
        taskBlock.startDate = startDate
        taskBlock.updatePlace()
        taskBlock.clicked.connect(taskBlockClicked)
        taskBlock.doubleClicked.connect(taskBlockDoubleClicked)
    }

    ColumnLayout {
        id: columnLayout
        anchors.fill: parent

        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.topMargin: -16

            Rectangle {
                id: rect
                anchors.fill: parent
                anchors.topMargin: 32
                radius: 16
            }

            DropShadow {
                anchors.fill: rect
                source: rect
                radius: 16.0
                samples: radius * 2
                color: "#50000000"
            }

            Item {
                id: plot
                anchors.fill: parent

                Flickable {
                    id: tasksFlickable
                    anchors.fill: parent

                    ScrollBar.horizontal: ScrollBar {
                        id: horizontalScrollBar
                        anchors.bottom: parent.top
                        anchors.bottomMargin: -8

                        background: Item {
                            Rectangle {
                                height: 12
                                anchors.left: parent.left
                                anchors.right: parent.right
                                anchors.leftMargin: 32
                                anchors.rightMargin: 32
                                radius: height / 2
                                color: "#25000000"
                            }
                        }

                        contentItem: Item {
                            Rectangle {
                                width: parent.width
                                height: 4
                                anchors.left: parent.left
                                anchors.right: parent.right
                                anchors.bottom: parent.bottom
                                anchors.bottomMargin: -6
                                anchors.leftMargin: 34
                                anchors.rightMargin: 34
                                radius: height / 2
                                color: "#818181"
                            }
                        }
                    }

                    contentWidth: row.width
                    clip: true

                    MouseArea {
                        anchors.fill: row
                        acceptedButtons: Qt.NoButton
                        onWheel: tasksFlickable.flick(wheel.angleDelta.y * 10, 0)
                    }

                    Row {
                        id: row
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.topMargin: 48
                        clip: true

                        Repeater {
                            model: 48

                            Item {
                                width: taskBoardTaskBlocks.sectionWidth
                                height: parent.height

                                Rectangle {
                                    width: 1
                                    height: parent.height
                                    color: "#20000000"
                                    anchors.right: parent.right
                                }

                                Text {
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    anchors.bottom: parent.bottom
                                    anchors.bottomMargin: 18
                                    font.pixelSize: 14

                                    text: {
                                        var date = new Date(taskBoardTaskBlocks.startDate.getTime() + (30 * 60 * 1000 * index))
                                        var h = date.getHours()
                                        var hs = (h < 10 ? "0" : "") + h
                                        var m = date.getMinutes()
                                        var ms = (m < 10 ? "0" : "") + m
                                        return `${hs}:${ms}`
                                    }
                                }
                            }
                        }
                    }

                    Item {
                        id: tasksFlickableItem
                        anchors.fill: row
                    }
                }
            }
        }
    }
}
