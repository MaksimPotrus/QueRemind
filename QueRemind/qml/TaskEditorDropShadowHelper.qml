import QtQuick 2.15
import QtGraphicalEffects 1.15

DropShadow {
    anchors.fill: source
    verticalOffset: 4
    radius: 4.0
    samples: radius * 2
    color: "#40000000"
}
