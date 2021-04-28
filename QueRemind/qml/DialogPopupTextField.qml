import QtQuick 2.15
import QtQuick.Controls 2.12

Item {
    height: 52

    TextField {
        x: 12
        width: parent.width - x*2
        height: parent.height
        background: Rectangle {
            implicitWidth: parent.width + 24
            implicitHeight: 52
            x: -12
            radius: 30
            color: "#aaffffff"
        }
    }
}

