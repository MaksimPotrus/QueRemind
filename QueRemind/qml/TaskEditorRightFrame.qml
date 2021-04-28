import QtQuick 2.15
import QtQuick.Controls 2.12
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.15

Item {
    id: item

    property alias selectedDate: calendar.selectedDate
    property alias existingTasksByDay: calendar.existingTasksByDay
    property alias existingTasks: calendar.existingTasks
    property alias remind: remindCheckBox.checked

    property int rectRadius
    property color taskColor
    property color selectedTextColor

    signal remindToggled(bool remind)

    Rectangle {
        id: rect
        anchors.fill: parent
        color: "#ffffff"
        radius: rectRadius
    }

    TaskEditorDropShadowHelper {
        source: rect
    }

    Column {
        anchors.fill: parent
        anchors.margins: 18

        TaskEditorCalendar {
            id: calendar
            width: parent.width
            height: 420
            taskColor: item.taskColor
            selectedTextColor: item.selectedTextColor
        }

        Text {
            width: parent.width
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 36
            font.weight: Font.Light
            font.family: "Catamaran Light"
            text: qsTr("Options")
        }

        VerticalSpacerItem {
            height: 18
        }

        CheckBox {
            id: remindCheckBox
            width: parent.width
            checked: false
            spacing: 16

            onToggled: remindToggled(checked)

            indicator: Rectangle {
                implicitWidth: 16
                implicitHeight: 16
                x: remindCheckBox.leftPadding
                y: parent.height / 2 - height / 2
                radius: 3
                color: "#c8c8c8"

                Rectangle {
                    anchors.fill: parent
                    anchors.margins: 2
                    radius: 3
                    color: Qt.darker("#c8c8c8")
                    visible: remindCheckBox.checked
                }
            }

            contentItem: Label {
                text: remindCheckBox.text
                font: remindCheckBox.font
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                leftPadding: remindCheckBox.indicator.width + remindCheckBox.spacing
                wrapMode: Label.WordWrap
            }

            font.pixelSize: 18
            font.weight: Font.Thin
            font.family: "Catamaran Thin"

            text: qsTr("Send me  messages to remind you of this event.")
        }
    }
}
