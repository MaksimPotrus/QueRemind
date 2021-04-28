import QtQuick 2.15

Rectangle {
    id: popupButton
    height: 31
    radius: 16
    color: "#9D4EDD"
    clip: true

    signal clicked()

    Image {
        id: image
        width: 22
        height: 9
        x: parent.width/2 - width/2
        y: parent.height/2 - height/2
        sourceSize.width: width
        sourceSize.height: height
        source: "qrc:/assets/icons/arrow-right.svg"
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: popupButton.clicked()

        onPressed: {
            image.x += 1
            image.y += 1
        }

        onReleased: {
            image.x -= 1
            image.y -= 1
        }
    }
}
