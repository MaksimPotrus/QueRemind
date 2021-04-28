import QtQuick 2.15

Rectangle {
    id: leftPanel
    color: "#cc3c096c"

    property alias userImage: userImageButton

    signal userImageClicked()
    signal editButtonClicked()
    signal messagesButtonClicked()
    signal settingsButtonClicked()
    signal otherButtonClicked()

    Column {
        anchors.fill: parent
        spacing: 2

        LeftPanelUserButton {
            id: userImageButton
            width: parent.width
            height: width
            image.source: "qrc:/assets/images/user.png"
            onClicked: leftPanel.userImageClicked()
        }

        LeftPanelButton {
            id: editButton
            width: parent.width
            height: width
            image.source: "qrc:/assets/icons/pen.svg"
            onClicked: leftPanel.editButtonClicked()
        }

        LeftPanelButton {
            id: messagesButton
            width: parent.width
            height: width
            image.source: "qrc:/assets/icons/im.svg"
            onClicked: leftPanel.messagesButtonClicked()
        }

        LeftPanelButton {
            id: settingsButton
            width: parent.width
            height: width
            image.source: "qrc:/assets/icons/cog.svg"
            onClicked: leftPanel.settingsButtonClicked()
        }

        LeftPanelButton {
            id: otherButton
            width: parent.width
            height: width
            image.source: "qrc:/assets/icons/dots.svg"
            onClicked: leftPanel.otherButtonClicked()
        }
    }
}
