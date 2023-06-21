import QtQuick
import QtQuick.Controls
import QtQuick.LocalStorage
import "../database_functions.js" as JS


TextInput {
    property bool isPassword: false
    property string formType: ""

    text: ""
    padding: 10
    color: "white"
    font.pixelSize: formType === "post" ? 15 : 13
    anchors.fill: parent
    selectByMouse: true
    selectionColor: "white"
    selectedTextColor: "#18181d"
    echoMode: isPassword ? TextInput.Password : TextInput.Normal
    passwordMaskDelay: isPassword ? 1000 : 0
}