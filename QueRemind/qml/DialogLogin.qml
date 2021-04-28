import QtQuick 2.15

DialogPopup {
    id: dialogLogin
    width: 456
    height: 528

    signal registrationClicked()
    signal googleInClicked()
    signal inClicked()

    Column {
        anchors.centerIn: parent
        width: 265
        spacing: 12

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 36
            font.weight: Font.Light
            color: "#ffffff"
            text: qsTr("Login in")
        }

        VerticalSpacerItem { height: 2 }

        DialogPopupTextField {
            width: parent.width
        }

        DialogPopupTextField {
            width: parent.width
        }

        DialogPopupButton {
            anchors.horizontalCenter: parent.horizontalCenter
            width: 104
            onClicked: inClicked()
        }

        VerticalSpacerItem { height: 18 }

        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 4

            DialogPopupTransparentButton {
                text.text: "Google in"
                text.color: "#ffffff"
                image.source: "qrc:/assets/icons/google-in.svg"
                onClicked: googleInClicked()
            }

            Rectangle {
                width: 1
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.topMargin: 10
                anchors.bottomMargin: 6
                color: "#ffffff"
            }

            DialogPopupTransparentButton {
                text.text: "Registration"
                text.color: "#0047ff"
                onClicked: registrationClicked()
            }
        }

        VerticalSpacerItem { height: 28 }
    }
}
