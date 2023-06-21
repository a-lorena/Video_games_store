import QtQuick
import QtQuick.Controls
import QtQuick.LocalStorage
import "../database_functions.js" as JS

Window {
    visible: true
    width: 1400
    height: 700
    visibility: "Maximized"
    title: "Game shop"

    Component.onCompleted: {
        JS.dbInit();
        var exists = JS.checkIfUserIsLoggedIn();

        if (exists) {
            view.push("main.qml")
        } else {
            view.push("login.qml")
        }
    }

    StackView {
            id: view
            anchors.fill: parent
            initialItem: "login.qml"
        }

}