import QtQuick 2.15
import QtGraphicalEffects 1.15

Item {
    id: button

    property alias image: image

    signal clicked()

    Rectangle {
        id: rect
        width: 32
        height: width
        anchors.centerIn: parent
        color: "#ffffff"
        radius: width / 2
    }

    DropShadow {
        id: shadow
        anchors.fill: rect
        source: rect
        radius: 12
        samples: radius * 2
        color: "#ffffff"
        opacity: 0.0
        Behavior on opacity { PropertyAnimation { duration: 250 }}
    }

    Image {
        id: image
        anchors.centerIn: parent
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        hoverEnabled: true
        onClicked: button.clicked()
        onEntered: shadow.opacity = 0.6
        onExited: shadow.opacity = 0.0
    }
}
