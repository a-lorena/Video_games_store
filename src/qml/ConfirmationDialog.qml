import QtQuick
import QtQuick.Controls
import QtQuick.Dialogs


Dialog {
    width: 200
    height: 100
    modal: true
    anchors.centerIn: parent

    property string dialogText: ""

    contentItem: Rectangle {
        anchors.fill: parent
        color: "#08aa64"
        border {
            color: "#3cf6a5"
            width: 3
        }

        Text {
            text: dialogText
            color: "white"
            font {
                pixelSize: 15
                weight: Font.Bold
            }
            anchors.centerIn: parent
        }
    }
}