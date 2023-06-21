import QtQuick
import QtQuick.Controls


Rectangle {
    property var buttonArea: newGamesButtonArea
    property string iconLight: ""
    property string iconDark: ""
    property string label: ""

    width: sidemenu.width - 50
    height: 50
    radius: 50
    color: buttonArea.containsMouse ? "#ff9431" : "transparent"
    
    Image {
        id: buttonIcon
        source: buttonArea.containsMouse ? iconDark : iconLight
        anchors {
            verticalCenter: parent.verticalCenter
            left: parent.left
            leftMargin: 30
        }
    }
    
    Text {
        id: buttonLabel
        text: label
        anchors {
            left: buttonIcon.right
            verticalCenter: parent.verticalCenter
            leftMargin: 10
        }
        color: buttonArea.containsMouse ? "#18181d" : "white"
        font {
            pixelSize: 15
            weight: Font.Bold
        }
    }
}