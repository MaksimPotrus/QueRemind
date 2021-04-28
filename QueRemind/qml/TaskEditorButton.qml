import QtQuick 2.15

Item {
    id: button
    width: 200
    height: 48

    property alias text: text.text
    property alias radius: rect.radius

    signal clicked()

    Rectangle {
        id: rect
        anchors.fill: parent
        color: "#ffffff"
    }

    TaskEditorDropShadowHelper {
        id: shadow
        source: rect
    }

    Text {
        id: text
        anchors.fill: rect
        anchors.topMargin: 4
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 18
        font.weight: Font.Light
        color: "#000000"
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onClicked: button.clicked()
        onPressed: {
            rect.anchors.topMargin = 2
            rect.anchors.bottomMargin = -2
        }
        onReleased: {
            rect.anchors.topMargin = 0
            rect.anchors.bottomMargin = 0
        }
    }
}
