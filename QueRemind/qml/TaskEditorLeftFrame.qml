import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.2
import QtQuick.Dialogs 1.3
import QtGraphicalEffects 1.15

Item {
    id: item

    property alias taskColor: taskColorRect.color
    property alias beginTime: beginTimeInput.value
    property alias endTime: endTimeInput.value
    property alias headText: headTextEdit.text
    property alias taskText: textArea.text
    property int rectRadius: 8
    property color selectionColor: "#222222"
    property color selectedTextColor: "#bbbbbb"

    signal cancelClicked()
    signal submitClicked()

    Rectangle {
        id: rect
        anchors.fill: parent
        radius: rectRadius
        color: "#ffffff"

        RowLayout {
            anchors.fill: parent
            anchors.margins: 16
            anchors.topMargin: 24

            Item {
                // left
                Layout.preferredWidth: 200
                Layout.preferredHeight: beginTimeInput.height + endTimeInput.height

                Column {
                    anchors.fill: parent

                    TaskEditorTimeInput {
                        id: beginTimeInput
                        width: parent.width
                        selectionColor: item.selectionColor
                        selectedTextColor: item.selectedTextColor
                        title: qsTr("Begin")
                        value: "08:00"
                    }

                    TaskEditorTimeInput {
                        id: endTimeInput
                        width: parent.width
                        selectionColor: item.selectionColor
                        selectedTextColor: item.selectedTextColor
                        title: qsTr("End")
                        value: "12:00"
                    }
                }
            }

            Item {
                // center
                Layout.fillWidth: true
                Layout.fillHeight: true

                ColumnLayout {
                    anchors.fill: parent


                            //Image {
                                //source: "qrc:/assets/icons/pen.svg"
                                //anchors.verticalCenter: parent.verticalCenter
                                //anchors.left: parent.left
                                //anchors.leftMargin: -24
                           // }

                    TextInput {
                        id: headTextEdit
                        Layout.minimumWidth: 24
                        Layout.maximumWidth: parent.width
                        Layout.alignment: Qt.AlignCenter
                        font.pixelSize: 48
                        horizontalAlignment: Text.AlignHCenter
                        selectByMouse: true
                        selectionColor: item.selectionColor
                        selectedTextColor: item.selectedTextColor
                        text: qsTr("Heading")
                        maximumLength: 60
                        wrapMode: TextInput.NoWrap
                        clip: true
                        rightPadding: 24
                        leftPadding: 24

                        Rectangle {
                            anchors.top: parent.top
                            anchors.bottom: parent.bottom
                            anchors.right: parent.right
                            anchors.rightMargin: -2
                            width: 26
                        }

                        Rectangle {
                            anchors.top: parent.top
                            anchors.bottom: parent.bottom
                            anchors.left: parent.left
                            anchors.leftMargin: -2
                            width: 26

                            Image {
                                source: "qrc:/assets/icons/pen.svg"
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 2
                            }

                            MouseArea {
                                anchors.fill: parent
                                cursorShape: Qt.PointingHandCursor
                                onClicked: {
                                    headTextEdit.focus = true
                                    headTextEdit.selectAll()
                                }
                            }
                        }
                    }

                    Item {
                        Layout.fillWidth: true
                        Layout.fillHeight: true

                        Rectangle {
                            id: textAreaRect
                            anchors.fill: parent
                            anchors.margins: 18
                            radius: rectRadius

                            Flickable {
                                id: textAreaFlickable
                                anchors.fill: parent
                                anchors.margins: 18

                                TextArea.flickable: TextArea {
                                    id: textArea
                                    font.pixelSize: 28
                                    selectByKeyboard: true
                                    selectByMouse: true
                                    selectionColor: item.selectionColor
                                    selectedTextColor: item.selectedTextColor
                                    wrapMode: TextArea.WordWrap
                                }

                                ScrollBar.vertical: ScrollBar { policy: ScrollBar.AsNeeded }
                                ScrollBar.horizontal: ScrollBar { policy: ScrollBar.AsNeeded }
                            }
                        }

                        TaskEditorDropShadowHelper {
                            source: textAreaRect
                        }
                    }

                    VerticalSpacerItem {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 18
                    }

                    Row {
                        Layout.alignment: Qt.AlignCenter
                        Layout.preferredWidth: childrenRect.width
                        Layout.preferredHeight: 80
                        spacing: 32

                        TaskEditorButton {
                            text: qsTr("Cancel")
                            radius: rectRadius
                            onClicked: item.cancelClicked()
                        }

                        TaskEditorButton {
                            text: qsTr("Submit")
                            radius: rectRadius
                            onClicked: item.submitClicked()
                        }
                    }
                }
            }

            Item {
                // right
                id: colorPickerItem
                Layout.preferredWidth: 200
                Layout.preferredHeight: 230

                Rectangle {
                    id: borderRect
                    anchors.fill: parent
                    anchors.margins: 16
                    radius: rectRadius
                }

                TaskEditorDropShadowHelper {
                    source: borderRect
                }

                Column {
                    anchors.fill: parent
                    anchors.margins: 32
                    spacing: 32

                    Text {
                        anchors.left: parent.left
                        anchors.right: parent.right
                        horizontalAlignment: Qt.AlignHCenter
                        wrapMode: Text.WordWrap
                        font.pixelSize: 18
                        font.weight: Font.Light
                        text: qsTr("Choose a color<br>of note:")
                    }

                    Rectangle {
                        id: taskColorRect
                        anchors.left: parent.left
                        anchors.right: parent.right
                        height: 30
                        color: "#7b2cbf"
                        radius: 10

                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                if (mouse.button == Qt.LeftButton) {
                                    colorPicker.visible = true
                                    colorPicker.x = width - colorPicker.width
                                    colorPicker.y = colorPickerItem.height / 2 - colorPicker.height / 2
                                }
                            }
                        }
                    }

                    ColorPickerPopup {
                        id: colorPicker
                        onPicked: {
                            taskColor = value
                            colorPicker.close()
                        }
                    }
                }
            }
        }
    }

    DropShadow {
        anchors.fill: rect
        radius: 10.0
        samples: radius * 2
        color: "#40000000"
        source: rect
    }
}
