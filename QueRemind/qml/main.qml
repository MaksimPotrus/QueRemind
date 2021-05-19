import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.0
import WinExtra 1.0

Window {
    id: rootWindow
    width: 1400
    height: 600
    minimumWidth: 1400
    minimumHeight: 800
    visible: true
    title: "QueRemind"
    color: "#80222222"

    property string footerText: "QueRemind © 2021"
    //flags: Qt.ToolTip | Qt.Window

    onVisibleChanged: {
        // Задержка активации прозрачности,
        // чтобы устранить баг с прозрачным titlebar
        if (visible) initBlurTimer.start()
        else rootWindow.color = "#20222222"
    }

    Timer {
        id: initBlurTimer
        running: false
        repeat: false
        interval: 100
        onTriggered: {
            rootWindow.color = "#20222222"
            WinExtra.initBlur(rootWindow)
        }
    }

    property DialogLogin dialogLogin: DialogLogin {
        visible: false

        onRegistrationClicked: {
            dialogRegistration.x = dialogLogin.x
            dialogRegistration.y = dialogLogin.y
            dialogLogin.visible = false
            dialogRegistration.visible = true
        }

        onInClicked: {
            visible = false
            rootWindow.visible = true
            console.log("DialogLogin button `->` clicked")
        }

        onGoogleInClicked: {
            console.log("DialogLogin googleInClicked")
        }
    }

    property DialogRegistration dialogRegistration: DialogRegistration {
        visible: false

        onLoginClicked: {
            dialogLogin.x = dialogRegistration.x
            dialogLogin.y = dialogRegistration.y
            dialogRegistration.visible = false
            dialogLogin.visible = true
        }

        onInClicked: {
            console.log("DialogRegistration button `->` clicked")
            dialogRegistration.visible = false
        }

        onGoogleInClicked: {
            console.log("DialogRegistration googleInClicked")
        }
    }

    Item {
        id: rootFrame
        anchors.fill: parent

        RowLayout {
            id: rootFrameRow
            anchors.fill: parent
            spacing: 0

            LeftPanel {
                Layout.fillHeight: true
                Layout.preferredWidth: 80

                onUserImageClicked: {
                    console.log("onUserImageClicked")
                    stackView.showItem(taskBoard)
                }

                onEditButtonClicked: console.log("onEditButtonClicked")
                onMessagesButtonClicked: console.log("onMessagesButtonClicked")
                onSettingsButtonClicked: console.log("onSettingsButtonClicked")
                onOtherButtonClicked: console.log("onOtherButtonClicked")
            }

            Item {
                id: stackView
                Layout.fillWidth: true
                Layout.fillHeight: true

                property Item activeItem: taskBoard

                function showItem(item) {
                    if (activeItem) {
                        activeItem.visible = false
                    }
                    activeItem = item
                    activeItem.visible = true
                }

                TaskBoard {
                    id: taskBoard
                    anchors.fill: parent
                    visible: true
                    sectionWidth: 160

                    userData: { "name": "John" }

                    todayTasks: [
                        {
                            "begin": new Date("2021-04-14 08:00:00"),
                            "end": new Date("2021-04-14 09:00:00"),
                            "lineNumber": 0,
                            "color": "#9949ff",
                            "title": "Mom's birthday", "text": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
                        },
                        {
                            "begin": new Date("2021-04-14 09:30:00"),
                            "end": new Date("2021-04-14 10:00:00"),
                            "lineNumber": 1,
                            "color": "#340f63",
                            "title": "Lorem ipsum", "text": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                        },
                        {
                            "begin": new Date("2021-04-14 11:00:00"),
                            "end": new Date("2021-04-14 11:30:00"),
                            "lineNumber": 1,
                            "color": "#C751FF",
                            "title": "Lorem ipsum dolor sit amet", "text": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
                        }
                    ]

                    onTaskBlockClicked: {
                        console.log("onTaskBlockClicked", taskData, taskData.title)
                    }

                    onTaskBlockDoubleClicked: {
                        console.log("onTaskBlockDoubleClicked", taskData, taskData.title)
                    }

                    onCreateNewTask: {
                        stackView.showItem(taskEditor)
                    }
                }

                TaskEditor {
                    id: taskEditor
                    anchors.fill: parent
                    taskColor: "#7b2cbf"
                    beginTime: "09:30"
                    endTime: "10:30"
                    headText: qsTr("Heading")
                    taskText: ""
                    rectRadius: 18
                    selectionColor: "#3c096c"
                    selectedTextColor: "#ffffff"
                    remind: false
                    visible: false

                    existingTasks: [
                        { "begin": new Date("2021-04-14 07:45:00"), "end": new Date("2021-04-14 09:45:00"), "color": "#9949ff" },
                        { "begin": new Date("2021-04-14 09:15:00"), "end": new Date("2021-04-14 10:15:00"), "color": "#340f63" },
                        { "begin": new Date("2021-04-15"), "end": new Date("2021-04-15") },
                        { "begin": new Date("2021-04-15"), "end": new Date("2021-04-15") },
                        { "begin": new Date("2021-04-15"), "end": new Date("2021-04-15") },
                        { "begin": new Date("2021-03-15"), "end": new Date("2021-04-15") },
                        { "begin": new Date("2021-03-15"), "end": new Date("2021-03-15") },
                        { "begin": new Date("2021-03-15"), "end": new Date("2021-03-15") },
                        { "begin": new Date("2021-03-16"), "end": new Date("2021-03-16") },
                        { "begin": new Date("2021-03-16"), "end": new Date("2021-03-16") },
                        { "begin": new Date("2021-02-18"), "end": new Date("2021-02-18") },
                        { "begin": new Date("2021-01-02"), "end": new Date("2021-01-02") },
                        { "begin": new Date("2021-01-02"), "end": new Date("2021-01-02") },
                    ]

                    onRemindToggled: {
                        console.log("Send me messages to remind you of this event:", remind, taskEditor.remind)
                    }
                }
            }
        }
    }

    Text {
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottomMargin: 8
        text: rootWindow.footerText
        color: "#000000"
        opacity: 0.8
        font.pixelSize: 14
    }
}
