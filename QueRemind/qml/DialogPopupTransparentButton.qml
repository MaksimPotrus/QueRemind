import QtQuick 2.12

Item {
    id: popupTransparentButton
    width: image.width + text.width + 8
    height: 32

    property alias text: text
    property alias image: image

    signal clicked()

    Image {
        id: image
        width: status == Image.Ready ? 32 : 0
        height: 32
        sourceSize.width: 32
        sourceSize.height: 32
        visible: status == Image.Ready
    }

    Text {
        id: text
        x: image.width > 0 ? image.width + 8 : 0
        y: parent.height/2 - height/2 + 2
        text: "Registration"
        color: "#0047FF"
        font.pixelSize: 12
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        hoverEnabled: true
        onClicked: popupTransparentButton.clicked()
        onEntered: text.font.underline = true
        onExited: text.font.underline = false

        onPressed: {
            image.x += 1
            image.y += 1
            text.x += 1
            text.y += 1
        }

        onReleased: {
            image.x -= 1
            image.y -= 1
            text.x -= 1
            text.y -= 1
        }
    }
}

