import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.2
import QtGraphicalEffects 1.15

Item {
    id: taskBoard

    property var userData
    property alias sectionWidth: taskBoardTaskBlocks.sectionWidth
    property alias blockHeight: taskBoardTaskBlocks.blockHeight
    property alias startDate: taskBoardTaskBlocks.startDate
    property alias todayTasks: taskBoardTodayTasks.tasks

    signal taskBlockClicked(var taskData)
    signal taskBlockDoubleClicked(var taskData)
    signal createNewTask()

    function updateTasks() {
        if (Array.isArray(todayTasks) && todayTasks.length > 0) {
            var i
            startDate = todayTasks[0].begin
            for (i = 1; i < todayTasks.length; i++) {
                if (todayTasks[i].begin < startDate) {
                    startDate = todayTasks[i].begin
                }
            }
            for (i = 0; i < todayTasks.length; i++) {
                taskBoardTaskBlocks.addTask(todayTasks[i])
            }
        }
    }

    onTodayTasksChanged: updateTasksTimer.restart()
    Component.onCompleted: updateTasksTimer.restart()

    Timer {
        id: updateTasksTimer
        repeat: false
        running: false
        interval: 100
        onTriggered: updateTasks()
    }

    Text {
        x: minimizeButton.x + (minimizeButton.width/2 - width/2)
        y: 64
        visible: taskBoardTodayTasks.visible
        font.pixelSize: 36
        font.weight: Font.Bold
        text: qsTr("Today")
    }

    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        visible: taskBoardTodayTasks.visible
        font.pixelSize: 30
        text: qsTr("Hi %1!").arg(userData.name)
    }

    Text {
        y: 28
        anchors.horizontalCenter: parent.horizontalCenter
        visible: taskBoardTodayTasks.visible
        font.pixelSize: 60
        font.weight: Font.Bold
        text: qsTr("Taskboard")
    }

    RowLayout {
        id: rowLayout
        anchors.fill: parent
        anchors.margins: 18
        anchors.leftMargin: 64
        anchors.rightMargin: taskBoardTodayTasks.visible ? 64 : 96
        anchors.topMargin: taskBoardTodayTasks.visible ? 150 : 48
        spacing: 0

        TaskBoardTodayTasks {
            id: taskBoardTodayTasks
            Layout.preferredWidth: 320
            Layout.fillHeight: true
        }

        TaskBoardTodayTaskBlocks {
            id: taskBoardTaskBlocks
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.bottomMargin: 48
            Layout.leftMargin: 64
            userName: userData.name
            onTaskBlockClicked: taskBoard.taskBlockClicked(taskData)
            onTaskBlockDoubleClicked: taskBoard.taskBlockDoubleClicked(taskData)
        }
    }

    Item {
        id: minimizeButton
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.topMargin: 48
        anchors.leftMargin: ((taskBoardTodayTasks.width / 2) - (width / 2))
                            + rowLayout.anchors.leftMargin - 8
        width: 180
        height: 12

        visible: taskBoardTodayTasks.visible

        Rectangle {
            width: parent.width
            height: 6
            anchors.centerIn: parent
            radius: height / 2
            color: "#696969"
        }

        Image {
            width: 8
            height: width
            anchors.centerIn: parent
            opacity: 0.6
            source: "qrc:/assets/icons/arrow-down.svg"
        }

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: taskBoardTodayTasks.visible = false
        }
    }

    Item {
        id: maximizeButton
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.bottomMargin: 16
        anchors.leftMargin: 96
        width: 80
        height: 12

        visible: !taskBoardTodayTasks.visible

        Rectangle {
            width: parent.width
            height: 8
            anchors.centerIn: parent
            radius: height / 2
            color: "#696969"
        }

        Image {
            width: 8
            height: width
            anchors.centerIn: parent
            opacity: 0.6
            source: "qrc:/assets/icons/arrow-up.svg"
        }

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: taskBoardTodayTasks.visible = true
        }
    }

    Rectangle {
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.topMargin: 28
        anchors.rightMargin: 28
        width: 48
        height: width
        radius: width/2
        color: "#9D4EDD"

        Image {
            width: parent.width - 16
            height: width
            anchors.centerIn: parent
            source: "qrc:/assets/icons/plus.svg"
        }

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: createNewTask()
        }
    }
}
