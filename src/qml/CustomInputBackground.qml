import QtQuick
import QtQuick.Controls
import QtQuick.LocalStorage
import "../database_functions.js" as JS


Rectangle {
    property string formType: ""

    width: formType === "post" ? 600 : parent.width - 100
    height: 30
    radius: 50
    color: "#454f57"
    border.width: 2
    anchors {
        horizontalCenter: formType === "post" ? undefined : parent.horizontalCenter
        topMargin: formType === "post" ? undefined : 5
    }
}