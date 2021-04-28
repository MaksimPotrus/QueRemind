import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.2
import QtGraphicalEffects 1.15

Item {
    id: todayTasks

    property alias tasks: listView.model

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        ListView {
            id: listView
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 0
            clip: true

            ScrollBar.vertical: ScrollBar {
                id: verticalScrollBar
                anchors.right: listView.right
                anchors.top: listView.top
                anchors.bottom: listView.bottom
                width: 12

                policy: height > listView.contentHeight ? ScrollBar.AlwaysOff : ScrollBar.AsNeeded

                background: Rectangle {
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.topMargin: 32
                    anchors.bottomMargin: 32
                    radius: width / 2
                    color: "#25000000"
                }

                contentItem: Item {
                    Rectangle {
                        anchors.fill: parent
                        anchors.margins: 2
                        anchors.topMargin: 34
                        anchors.bottomMargin: 34
                        radius: width / 2
                        color: "#7b2cbf"
                    }
                }
            }

            delegate: Item {
                id: delegateItem
                width: listView.width - 14
                height: defaultHeight
                clip: true

                property int defaultHeight: Math.max(120, Math.min(300, textArea.implicitHeight)) + 64

                Behavior on height {
                    id: behaviorOnHeight
                    enabled: false
                    PropertyAnimation { duration: 500; easing.type: Easing.InOutBack }
                }

                Rectangle {
                    id: rect
                    anchors.fill: parent
                    anchors.margins: 18
                    color: "#ffffff"
                    radius: 12
                    clip: true

                    Text {
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: parent.top
                        anchors.topMargin: 22
                        text: modelData.title
                        font.pixelSize: 14
                    }

                    Item {
                        anchors.fill: parent
                        anchors.margins: 22
                        anchors.topMargin: 48
                        clip: true

                        Flickable {
                            id: textAreaFlickable
                            anchors.fill: parent
                            anchors.bottomMargin: textArea.implicitHeight > 280 ? 18 : 0
                            clip: true

                            TextArea.flickable: TextArea {
                                id: textArea
                                font.pixelSize: 13
                                selectByKeyboard: true
                                selectByMouse: true
                                readOnly: true
                                wrapMode: TextArea.WordWrap
                                text: modelData.text
                                clip: true
                            }

                            onFlickStarted: textAreaVerticalScrollBar.opacity = 1.0
                            onFlickEnded: textAreaVerticalScrollBar.opacity = 0.1

                            ScrollBar.vertical: ScrollBar {
                                id: textAreaVerticalScrollBar
                                anchors.right: textAreaFlickable.left
                                width: 12
                                background: Item {}
                                policy: height > textArea.implicitHeight ? ScrollBar.AlwaysOff : ScrollBar.AsNeeded
                                opacity: 0.1

                                Behavior on opacity { PropertyAnimation {}}

                                contentItem: Item {
                                    Rectangle {
                                        width: 3
                                        height: parent.height
                                        anchors.left: parent.right
                                        radius: width / 2
                                        color: "#9D4EDD"
                                    }
                                }

                                MouseArea {
                                    anchors.fill: parent
                                    hoverEnabled: true
                                    onEntered: textAreaVerticalScrollBar.opacity = 1.0
                                    onExited: textAreaVerticalScrollBar.opacity = 0.1
                                    propagateComposedEvents: true
                                    acceptedButtons: Qt.NoButton
                                    onWheel: textAreaFlickable.flick(0, wheel.angleDelta.y * 4)
                                }
                            }
                        }

                        Rectangle {
                            width: parent.width
                            height: textAreaFlickable.atYEnd ? 8 : 96
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: 16
                            visible: maximizeButton.visible

                            Behavior on height { PropertyAnimation { duration: 200 }}

                            gradient: Gradient {
                                GradientStop { position: 0.0; color: "#10ffffff" }
                                GradientStop { position: 1.0; color: "#ffffffff" }
                            }
                        }
                    }

                    Item {
                        id: maximizeButton
                        width: 22
                        height: 22
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 18
                        visible: textArea.implicitHeight > 280

                        property bool isMaximized: false

                        Image {
                            id: maximizeImage
                            anchors.centerIn: parent
                            source: "qrc:/assets/icons/down-down.svg"
                            transformOrigin: Item.Center
                            Behavior on rotation { PropertyAnimation { duration: 200 }}
                        }

                        DropShadow {
                            anchors.fill: maximizeImage
                            source: maximizeImage
                            radius: 1
                            samples: radius * 4
                            color: "#7b2cbf"
                            opacity: 0.5
                            rotation: maximizeImage.rotation
                        }

                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                behaviorOnHeight.enabled = true
                                maximizeButton.isMaximized = !maximizeButton.isMaximized
                                if (maximizeButton.isMaximized) {
                                    delegateItem.height = textArea.contentHeight + 148
                                    maximizeImage.rotation = 180
                                }
                                else {
                                    delegateItem.height = delegateItem.defaultHeight
                                    maximizeImage.source = "qrc:/assets/icons/down-down.svg"
                                    maximizeImage.rotation = 0
                                }
                            }
                        }
                    }
                }

                DropShadow {
                    anchors.fill: rect
                    source: rect
                    radius: 16.0
                    samples: radius * 2
                    color: "#50000000"
                }
            }
        }
    }
}
