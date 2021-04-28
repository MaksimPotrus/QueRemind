import QtQuick 2.15

Rectangle {
    id: taskBlock

    property var sectionWidth: 100
    property var taskData: ({})
    property var startDate: new Date()

    height: 155
    anchors.margins: 16
    anchors.bottom: parent.bottom
    radius: 16

    signal clicked(var taskData)
    signal doubleClicked(var taskData)

    function updatePlace() {
        // x
        taskBlock.x = (Math.floor((taskData.begin.getTime() - startDate.getTime()) / 1000 / 60) * sectionWidth / 30) + 15

        // width
        var durationInMinutes = Math.floor((taskData.end.getTime() - taskData.begin.getTime()) / 1000 / 60)
        taskBlock.width = (durationInMinutes * sectionWidth / 30) + sectionWidth - 30

        // bottomMargin
        taskBlock.anchors.bottomMargin = 64 + (taskData.lineNumber * height) + (taskData.lineNumber * 16)

        // ...
        taskBlock.color = taskData.color
        taskBlock.visible = true
    }

    MouseArea {
        anchors.fill: parent
        onClicked: taskBlock.clicked(taskData)
        onDoubleClicked: taskBlock.doubleClicked(taskData)
    }
}
