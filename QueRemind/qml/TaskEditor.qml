import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.2
import QtQuick.Dialogs 1.3
import QtGraphicalEffects 1.15

Item {
    id: taskEditor

    property alias taskColor: taskEditorLeftFrame.taskColor
    property alias beginTime: taskEditorLeftFrame.beginTime
    property alias endTime: taskEditorLeftFrame.endTime
    property alias headText: taskEditorLeftFrame.headText
    property alias taskText: taskEditorLeftFrame.taskText
    property alias existingTasks: taskEditorRightFrame.existingTasks
    property alias remind: taskEditorRightFrame.remind
    property int rectRadius: 4
    property color selectionColor: "#222222"
    property color selectedTextColor: "#bbbbbb"

    signal remindToggled(bool remind)
    signal cancelClicked()
    signal submitClicked()

    LinearGradient {
        anchors.fill: parent
        start: Qt.point(0, 0)
        end: Qt.point(0, parent.height)
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#90ffffff" }
            GradientStop { position: 1.0; color: "#90e3e3e3" }
        }
    }

    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: 16
        anchors.rightMargin: 16
        anchors.topMargin: 32
        anchors.bottomMargin: 64
        spacing: 16

        TaskEditorLeftFrame {
            id: taskEditorLeftFrame
            Layout.fillWidth: true
            Layout.fillHeight: true
            rectRadius: taskEditor.rectRadius
            selectionColor: taskEditor.selectionColor
            selectedTextColor: taskEditor.selectedTextColor
            onCancelClicked: taskEditor.cancelClicked()
            onSubmitClicked: taskEditor.submitClicked()
        }

        TaskEditorRightFrame {
            id: taskEditorRightFrame
            Layout.preferredWidth: 380
            Layout.fillHeight: true
            rectRadius: taskEditor.rectRadius
            taskColor: taskEditorLeftFrame.taskColor
            selectedTextColor: taskEditor.selectedTextColor
            onRemindToggled: taskEditor.remindToggled(remind)
        }
    }
}
