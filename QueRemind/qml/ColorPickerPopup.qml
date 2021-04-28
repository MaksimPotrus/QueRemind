import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.15

Popup {
    id: popup
    modal: true
    focus: true
    closePolicy: Popup.CloseOnPressOutside
    width: cellSize * columns + padding * 2
    height: cellSize * Math.ceil(repeater.count / columns) + padding * 2
    padding: 4

    property int columns: 6
    property int cellSize: 48
    property int hoverScaling: 4

    signal picked(var value)

    enter: Transition {
        NumberAnimation {
            property: "scale"
            from: 0.0
            to: 1.0
            duration: 200
            easing.type: Easing.OutQuart
        }
    }

    exit: Transition {
        NumberAnimation {
            property: "scale"
            from: 1.0
            to: 0.0
            duration: 200
            easing.type: Easing.OutQuart
        }
    }

    Repeater {
        id: repeater
        anchors.fill: parent

        model: [
            "#10002B", "#240046", "#3C096C", "#5A189A", "#7B2CBF", "#9D4EDD",
            "#560BAD", "#7209B7", "#B5179E", "#AB47BC", "#C77DFF", "#E0AAFF",
            "#480CA8", "#3A0CA3", "#3F37C9", "#4361EE", "#4895EF", "#4CC9F0",
            "#c62828", "#c0392b", "#d35400", "#e67e22", "#f39c12", "#f1c40f",
            "#33691E", "#558B2F", "#689F38", "#7CB342", "#8BC34A", "#9CCC65",
            "#455A64", "#607D8B", "#7f8c8d", "#95a5a6", "#bdc3c7", "#ecf0f1"
        ]

        delegate: Item {
            id: item
            width: cellSize
            height: cellSize
            x: ox
            y: oy
            z: 1

            property var easingTypeIn: Easing.InQuart
            property var easingTypeOut: Easing.OutQuint
            property var easingType: Easing.InQuart

            property int ox: cellSize * (index % popup.columns)
            property int oy: cellSize * Math.floor(index / popup.columns)

            Behavior on x { PropertyAnimation { easing.type: item.easingType } }
            Behavior on y { PropertyAnimation { easing.type: item.easingType } }
            Behavior on width { PropertyAnimation { easing.type: item.easingType } }
            Behavior on height { PropertyAnimation { easing.type: item.easingType } }

            Rectangle {
                id: colorRect
                anchors.fill: parent
                color: modelData

                Item {
                    id: colorRectBorder
                    anchors.fill: parent
                    anchors.margins: 2
                    opacity: 0.0

                    Behavior on opacity { PropertyAnimation { easing.type: item.easingType } }

                    Rectangle {
                        id: colorRectDarkerBorder
                        anchors.fill: parent
                        color: "transparent"
                        border.color: Qt.darker(modelData, 1.4)
                    }

                    Rectangle {
                        id: colorRectLighterBorder
                        anchors.fill: parent
                        anchors.margins: 1
                        color: "transparent"
                        border.color: Qt.lighter(modelData, 1.4)
                    }
                }
            }

            DropShadow {
                id: colorRectShadow
                anchors.fill: colorRect
                radius: 4.0
                opacity: colorRectBorder.opacity
                samples: radius * 2
                color: "#ff000000"
                source: colorRect
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor

                onEntered: {
                    easingType = easingTypeIn
                    colorRectBorder.opacity = 1.0
                    item.x = ox - hoverScaling
                    item.y = oy - hoverScaling
                    item.width = cellSize + hoverScaling * 2
                    item.height = cellSize + hoverScaling * 2
                    item.z = 3
                }

                onExited: {
                    easingType = easingTypeOut
                    colorRectBorder.opacity = 0.0
                    item.x = ox
                    item.y = oy
                    item.width = cellSize
                    item.height = cellSize
                    item.z = 2
                }

                onClicked: {
                    picked(modelData)
                }
            }
        }
    }
}
