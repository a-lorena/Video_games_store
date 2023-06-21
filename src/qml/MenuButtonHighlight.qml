import QtQuick
import QtQuick.Controls


Rectangle {
    property var button: newGamesButton
    property var buttonArea: newGamesButtonArea

    color: "#ff9431"
    height: 50
    visible: buttonArea.containsMouse ? true : false
    anchors {
        top: button.top
        left: parent.left
        right: button.right
        rightMargin: 50
    }
}