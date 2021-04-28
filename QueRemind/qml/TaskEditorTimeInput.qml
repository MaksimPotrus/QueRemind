import QtQuick 2.15
import QtGraphicalEffects 1.15
import QtQuick.Controls 2.2

Item {
    id: timeInput
    height: title.height + textInputItem.height

    property alias title: title.text
    property alias value: textInput.text

    property alias selectionColor: textInput.selectionColor
    property alias selectedTextColor: textInput.selectedTextColor

    Column {
        anchors.fill: parent
        spacing: -22

        Text {
            id: title
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 28
            font.weight: Font.Light
        }

        Item {
            id: textInputItem
            width: parent.width
            height: textInput.height + 32

            Rectangle {
                id: textInputRect
                anchors.fill: parent
                anchors.margins: 16
                radius: 18

                MouseArea {
                    anchors.fill: textInput
                    propagateComposedEvents: true
                    scrollGestureEnabled: true

                    onWheel: {
                        if (wheel.angleDelta.y == 0) return
                        if (wheel.y < textInput.height / 4) return
                        if (wheel.y > textInput.height / 1.25) return

                        var time = textInput.text.split(':')
                        var h = parseInt(time[0], 10)
                        var m = parseInt(time[1], 10)
                        var d = wheel.angleDelta.y > 0 ? 1 : -1

                        if (wheel.x < textInput.width / 2) {
                            if (d > 0) h = (h + d) % 23
                            else h = h === 1 ? 23 : (h + d) % 23
                        }
                        else {
                            if (d > 0) m = (m + d) % 59
                            else m = m === 1 ? 59 : (m + d) % 59
                        }

                        var hs, ms
                        if (h < 10) hs += "0"
                        if (m < 10) ms += "0"

                        textInput.text = `${hs}${h}:${ms}${m}`
                    }
                }

                TextInput {
                    id: textInput
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.leftMargin: 10
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: 64
                    font.family: "Chathura"
                    font.weight: Font.Normal
                    font.letterSpacing: 10
                    selectByMouse: true
                    text: "12:00"
                    inputMask: "99:99"
                    inputMethodHints: Qt.ImhDigitsOnly
                    validator: RegExpValidator { regExp: /^([0-1\s]?[0-9\s]|2[0-3\s]):([0-5\s][0-9\s])$ / }
                }
            }

            TaskEditorDropShadowHelper {
                source: textInputRect
            }
        }
    }
}
