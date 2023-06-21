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
        height: 420
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
            formType: "register"
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
            formType: "register"
            border.color: passwordInput.activeFocus ? "white" : "transparent"
            anchors.top: passwordLabel.bottom

            CustomInputField {
                id: passwordInput
                isPassword: true
            }
        }

        // REPEAT PASSWORD LABEL
        Text {
            id: repeatPasswordLabel
            text: "Ponovite lozinku"
            color: "white"
            font.pixelSize: 15
            anchors {
                top: passwordInputBackground.bottom
                left: passwordInputBackground.left
                topMargin: 15
                leftMargin: 10
            }
        }

        // REPEAT PASSWORD INPUT
        CustomInputBackground {
            id: repeatPasswordBackground
            formType: "register"
            border.color: repeatPasswordInput.activeFocus ? "white" : "transparent"
            anchors.top: repeatPasswordLabel.bottom

            CustomInputField {
                id: repeatPasswordInput
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
                top: repeatPasswordBackground.bottom
                horizontalCenter: parent.horizontalCenter
                topMargin: 10
            }
        }

        // REGISTER BUTTON
        Rectangle {
            id: registerButton
            width: parent.width - 150
            height: 40
            color: registerButtonArea.containsMouse ? "#55b3f7" : "#0977c3"
            radius: 10
            anchors {
                top: repeatPasswordBackground.bottom
                horizontalCenter: parent.horizontalCenter
                topMargin: 50
            }

            Text {
                text: "Registriraj me"
                anchors.centerIn: parent
                color: "white"
                font {
                    pixelSize: 15
                    weight: Font.Bold
                }
            }

            MouseArea {
                id: registerButtonArea
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    warningText.visible = false

                    if (usernameInput.text == "" && passwordInput.text == "" && repeatPasswordInput.text == "") {
                        warningText.text = "Unesite sve podatke!"
                        warningText.visible = true
                    } else if (usernameInput.text == "") {
                        warningText.text = "Unesite korisničko ime!"
                        warningText.visible = true
                    } else if (passwordInput.text == "") {
                        warningText.text = "Unesite lozinku!"
                        warningText.visible = true
                    } else if (repeatPasswordInput.text == "") {
                        warningText.text = "Ponovite lozinku!"
                        warningText.visible = true
                    } else {
                        if (passwordInput.text === repeatPasswordInput.text) {
                            var exists = JS.checkIfUserExists(usernameInput.text);

                            if (!exists) {
                                JS.registerUser(usernameInput.text, passwordInput.text);
                                view.push("login.qml")
                            } else {
                                warningText.text = "Korisnik već postoji!"
                                warningText.visible = true
                            }
                            
                        } else {
                            warningText.text = "Lozinke nisu jednake!"
                            warningText.visible = true
                        }
                    }
                }
            }
        }


        // LOGIN LINK
        Text {
            id: loginLink
            text: "Prijava"
            color: loginMouseArea.containsMouse ? "white": "#6b86ae"
            font.pixelSize: 13
            anchors {
                top: registerButton.bottom
                horizontalCenter: parent.horizontalCenter
                topMargin: 15
            }
            
            MouseArea {
                id: loginMouseArea
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: view.push("login.qml")
            }
        }
    }
}