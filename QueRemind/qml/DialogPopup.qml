import QtQuick 2.15
import QtQuick.Window 2.15
import WinExtra 1.0

Window {
    id: dialogPopup
    flags: Qt.FramelessWindowHint | Qt.Window
    color: "transparent"

    Component.onCompleted: {
        WinExtra.initBlur(dialogPopup)
    }

    Rectangle {
        anchors.fill: parent
        color: "#803C096C"
        radius: 4

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 26
            text: rootWindow.footerText
            color: "#ffffff"
            opacity: 0.8
            font.pixelSize: 14
        }

        Rectangle {
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.margins: 8
            width: 16
            height: 16
            radius: 8
            color: "#F73B3B"
        }
    }

    MouseArea {
        anchors.fill: parent
        property variant previousPosition
        onPressed: previousPosition = Qt.point(mouseX, mouseY)
        onPositionChanged: {
            if (pressedButtons == Qt.LeftButton) {
                var dx = mouseX - previousPosition.x
                var dy = mouseY - previousPosition.y
                dialogPopup.x += dx
                dialogPopup.y += dy
            }
        }
    }

    Rectangle {
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.margins: 8
        width: 16
        height: 16
        radius: 8
        color: "#F73B3B"

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: dialogPopup.close()
        }
    }
}
