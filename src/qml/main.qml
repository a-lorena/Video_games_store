import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.LocalStorage
import "../database_functions.js" as JS

Item {
    visible: true
    width: parent.width
    height: parent.height

    function changeSelected(selected) {
        newGamesSelected.visible = false;
        usedGamesSelected.visible = false;
        ordersSelected.visible = false;
        profileSelected.visible = false;

        selected.visible = true;
    }

    Component.onCompleted: {
        changeSelected(newGamesSelected)
    }

    // SIDEBAR
    Rectangle {
        id: sidemenu
        width: 200
        height: parent.height
        color: "#18181d"
        anchors {
            top: parent.top
            left: parent.left
        }

        // NEW GAMES BUTTON
        MenuButtonSelected {
            id: newGamesSelected
            anchors.top: newGamesButton.top
        }
        MenuButtonHighlight {
            id: newGamesHighlight
            button: newGamesButton
            buttonArea: newGamesButtonArea
        }
        MenuButton {
            id: newGamesButton
            buttonArea: newGamesButtonArea
            iconLight: "../icons/newIconLight"
            iconDark: "../icons/newIconDark"
            label: "Novo"
            anchors {
                top: parent.top
                left: parent.left
                topMargin: 50
            }
            MenuButtonMouseArea {
                id: newGamesButtonArea
                sourceFile: "newGames.qml"
                selectedButton: newGamesSelected
            }
        }

        // USED GAMES BUTTON
        MenuButtonSelected {
            id: usedGamesSelected
            anchors.top: usedGamesButton.top
        }
        MenuButtonHighlight {
            id: usedGamesHighlight
            button: usedGamesButton
            buttonArea: usedGamesButtonArea
        }
        MenuButton {
            id: usedGamesButton
            buttonArea: usedGamesButtonArea
            iconLight: "../icons/usedIconLight"
            iconDark: "../icons/usedIconDark"
            label: "Polovno"
            anchors {
                top: newGamesButton.bottom
                left: parent.left
                topMargin: 20
            }
            MenuButtonMouseArea {
                id: usedGamesButtonArea
                sourceFile: "usedGames.qml"
                selectedButton: usedGamesSelected
            }
        }

        // ORDERS BUTTON
        MenuButtonSelected {
            id: ordersSelected
            anchors.top: ordersButton.top
        }
        MenuButtonHighlight {
            id: ordersHighlight
            button: ordersButton
            buttonArea: ordersButtonArea
        }
        MenuButton {
            id: ordersButton
            buttonArea: ordersButtonArea
            iconLight: "../icons/ordersIconLight"
            iconDark: "../icons/ordersIconDark"
            label: "Narudžbe"
            anchors {
                top: usedGamesButton.bottom
                left: parent.left
                topMargin: 20
            }
            MenuButtonMouseArea {
                id: ordersButtonArea
                sourceFile: "orders.qml"
                selectedButton: ordersSelected
            }
        }

        // PROFILE BUTTON
        MenuButtonSelected {
            id: profileSelected
            anchors.top: profileButton.top
        }
        MenuButtonHighlight {
            id: profileHighlight
            button: profileButton
            buttonArea: profileButtonArea
        }
        MenuButton {
            id: profileButton
            buttonArea: profileButtonArea
            iconLight: "../icons/profileIconLight"
            iconDark: "../icons/profileIconDark"
            label: JS.findUser()[1]
            anchors {
                bottom: parent.bottom
                left: parent.left
                bottomMargin: 50
            }
            MenuButtonMouseArea {
                id: profileButtonArea
                sourceFile: "profile.qml"
                selectedButton: profileSelected
            }
        }
    }

    Rectangle {
        id: content
        width: parent.width - sidemenu.width
        height: parent.height
        color: "#212529"
        anchors {
            top: parent.top
            left: sidemenu.right
        }

        Loader {
            id: pages
            anchors.fill: parent
            source: "newGames.qml"
        }
    }
}