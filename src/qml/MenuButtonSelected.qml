import QtQuick
import QtQuick.Controls


Rectangle {
    height: 200
    width: 50
    visible: false
    anchors.right: parent.right
    gradient: MenuButtonGradient {}
    transform: Rotation {
        origin.x: 25
        origin.y: 25
        angle: 90
    }
}