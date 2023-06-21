import QtQuick
import QtQuick.Controls
import QtQuick.LocalStorage
import QtQuick.Layouts
import "../database_functions.js" as JS

Window {
    visible: false
    width: 800
    height: 450
    title: "Nova objava"
    color: "#18181d"
    
    GridLayout {
        id: formLayout
        columns: 2
        anchors {
            top: parent.top
            horizontalCenter: parent.horizontalCenter
            topMargin: 30
        }
        Layout.alignment: Qt.AlignCenter
        columnSpacing: 10
        rowSpacing: 20

        // GAME TITLE
        Text {
            text: "Naslov:"
            color: "white"
            font.pixelSize: 15
        }
        CustomInputBackground {
            formType: "post"
            border.color: titleInput.activeFocus ? "white": "transparent"
            
            CustomInputField {
                id: titleInput
                formType: "post"
                isPassword: false
                maximumLength: 50
            }
        }

        // GAME GENRE
        Text {
            text: "Žanr:"
            color: "white"
            font.pixelSize: 15
        }
        CustomInputBackground {
            formType: "post"
            border.color: genreInput.activeFocus ? "white": "transparent"
            
            CustomInputField {
                id: genreInput
                formType: "post"
                isPassword: false
                maximumLength: 50
            }
        }

        // GAME DESCRIPTION
        Text {
            text: "Opis:"
            color: "white"
            font.pixelSize: 15
        }
        CustomInputBackground {
            formType: "post"
            height: 150
            radius: 20
            border.color: descriptionInput.activeFocus ? "white": "transparent"
            
            CustomInputField {
                id: descriptionInput
                formType: "post"
                isPassword: false
                maximumLength: 400
                wrapMode: TextEdit.Wrap
            }
        }

        // GAME PRICE
        Text {
            text: "Cijena (HRK):"
            color: "white"
            font.pixelSize: 15
        }
        CustomInputBackground {
            formType: "post"
            border.color: priceInput.activeFocus ? "white": "transparent"
            
            CustomInputField {
                id: priceInput
                formType: "post"
                isPassword: false
                maximumLength: 6
            }
        }
        
    }

    // WARNING MESSAGE
    Text {
        id: warningText
        text: "Upozorenje"
        color: "#e66262"
        font.pixelSize: 13
        visible: false
        anchors {
            top: formLayout.bottom
            horizontalCenter: parent.horizontalCenter
            topMargin: 10
        }
    }

    // POST BUTTON
    Rectangle {
		id: postButton
		width: 150
		height: 40
        radius: 10
		color: postButtonArea.containsMouse ? "#ffc64d" : "#e69d00"
        anchors {
            top: warningText.bottom
            right: parent.horizontalCenter
            topMargin: 20
            rightMargin: 20
        }
		Text {
			text: "Objavi"
            color: "white"
            font {
                pixelSize: 15
                weight: Font.Bold
            }
			anchors.centerIn: parent
		}
		MouseArea {
			id: postButtonArea
			anchors.fill: parent
		    hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
		    onClicked: {
                if (titleInput.text === "" || genreInput.text === "" || 
                    descriptionInput.text === "" || priceInput.text === "") {
                        warningText.text = "Unesite sve podatke!"
                        warningText.visible = true
                } else {
                    JS.savePost(titleInput.text,
                                genreInput.text, 
								descriptionInput.text,
                                priceInput.text,
								profileButton.label)
                    titleInput.clear()
                    genreInput.clear()
                    descriptionInput.clear()
                    priceInput.clear()
                    warningText.visible = false
                    pages.setSource("profile.qml")
                    close()
                }
            }
		}
	}

    // CANCEL BUTTON
    Rectangle {
		id: cancelButton
		width: 150
		height: 40
        radius: 10
		color: cancelButtonArea.containsMouse ? "#fe8480" : "#fe413c"
        anchors {
            top: postButton.top
            left: parent.horizontalCenter
            leftMargin: 20
        }
		Text {
			text: "Odustani"
            color: "white"
            font {
                pixelSize: 15
                weight: Font.Bold
            }
			anchors.centerIn: parent
		}
		MouseArea {
			id: cancelButtonArea
			anchors.fill: parent
		    hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
		    onClicked: {
                titleInput.clear()
                genreInput.clear()
                descriptionInput.clear()
                priceInput.clear()
                warningText.visible = false
                close()
            }
		}
	}
}