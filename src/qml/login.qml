import QtQuick
import QtQuick.Controls
import QtQuick.LocalStorage
import "../database_functions.js" as JS

Item {
    visible: true
    width: parent.width
    height: parent.height

    // BACKGROUND
    Rectangle {
        anchors.fill: parent
        color: "#11181a"
    }

    // FORM BACKGROUND
    Rectangle {
        anchors.centerIn: parent
        width: 300
        height: 350
        radius: 20
        color: "#2a2d35"

        // USERNAME LABEL
        Text {
            id: usernameLabel
            text: "Korisničko ime"
            color: "white"
            font.pixelSize: 15
            anchors {
                top: parent.top
                left: usernameInputBackground.left
                topMargin: 70
                leftMargin: 10
            }
        }

        // USERNAME INPUT
        CustomInputBackground {
            id: usernameInputBackground
            formType: "login"
            border.color: usernameInput.activeFocus ? "white" : "transparent"
            anchors.top: usernameLabel.bottom

            CustomInputField {
                id: usernameInput
                isPassword: false
            }
        }

        // PASSWORD LABEL
        Text {
            id: passwordLabel
            text: "Lozinka"
            color: "white"
            font.pixelSize: 15
            anchors {
                top: usernameInputBackground.bottom
                left: usernameInputBackground.left
                topMargin: 15
                leftMargin: 10
            }
        }

        // PASSWORD INPUT
        CustomInputBackground {
            id: passwordInputBackground
            formType: "login"
            border.color: passwordInput.activeFocus ? "white" : "transparent"
            anchors.top: passwordLabel.bottom

            CustomInputField {
                id: passwordInput
                isPassword: true
            }
        }

        // WARNING TEXT
        Text {
            id: warningText
            text: "Upozorenje"
            color: "#e66262"
            font.pixelSize: 13
            visible: false
            anchors {
                top: passwordInputBackground.bottom
                horizontalCenter: parent.horizontalCenter
                topMargin: 10
            }
        }

        // LOGIN BUTTON
        Rectangle {
            id: loginButton
            width: parent.width - 150
            height: 40
            color: loginButtonArea.containsMouse ? "#55b3f7" : "#0977c3"
            radius: 10
            anchors {
                top: passwordInputBackground.bottom
                horizontalCenter: parent.horizontalCenter
                topMargin: 50
            }

            Text {
                text: "Prijavi se"
                anchors.centerIn: parent
                color: "white"
                font {
                    pixelSize: 15
                    weight: Font.Bold
                }
            }

            MouseArea {
                id: loginButtonArea
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    warningText.visible = false

                    if (usernameInput.text == "" && passwordInput.text == "") {
                        warningText.text = "Unesite sve podatke!"
                        warningText.visible = true
                    } else if (usernameInput.text == "") {
                        warningText.text = "Unesite korisničko ime!"
                        warningText.visible = true
                    } else if (passwordInput.text == "") {
                        warningText.text = "Unesite lozinku!"
                        warningText.visible = true
                    } else {
                        var result = JS.loginUser(usernameInput.text, passwordInput.text);

                        if (result == false) {
                            warningText.text = "Netočni podaci!"
                            warningText.visible = true
                        } else {
                            view.push("main.qml")
                        }
                    }
                }
            }
        }

        // REGISTER LINK
        Text {
            id: registerLink
            text: "Registriraj se"
            color: registerMouseArea.containsMouse ? "white" : "#6b86ae"
            font.pixelSize: 13
            anchors {
                top: loginButton.bottom
                horizontalCenter: parent.horizontalCenter
                topMargin: 15
            }

            MouseArea {
                id: registerMouseArea
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: view.push("register.qml")
            }
        }
    }
}