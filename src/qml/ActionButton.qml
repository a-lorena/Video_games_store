import QtQuick
import QtQuick.Controls
import QtQuick.LocalStorage
import QtQuick.Dialogs
import "../database_functions.js" as JS


Rectangle {
    function buttonVisibility(buttonType) {
        if (buttonType === "buy") {
            return postsDelegate.delegateType === "profile" ? false : true
        } else {
            return seller === profileButton.label ? true : false
        }
    }
    
    visible: buttonVisibility(actionButton.buttonType)
    width: actionButton.buttonType === "buy" ? 120 : 75
    height: 40
    radius: 10
    color: buttonArea.containsMouse ? "#0adb81": "#08aa64"
    anchors {
        bottom: parent.bottom
        right: parent.right
        margins: 10
    }

    // SELL BUTTON TEXT
    Text {
        visible: actionButton.buttonType === "sell" ? true : false
        text: "Prodaj"
        anchors.centerIn: parent
        color: "white"
        font {
            pixelSize: 15
            weight: Font.Bold
        }
    }

    // BUY BUTTON TEXT
    Text {
        id: itemPrice
        visible: actionButton.buttonType === "buy" ? true : false
        text: price
        color: "white"
        anchors {
            verticalCenter: parent.verticalCenter
            right: priceCurrency.left
            rightMargin: 5
        }
        font {
            pixelSize: 15
            weight: Font.Bold
        }
    }
    Text {
        id: priceCurrency
        visible: actionButton.buttonType === "buy" ? true : false
        text: "HRK"
        color: "white"
        anchors {
            verticalCenter: parent.verticalCenter
            right: parent.right
            rightMargin: 20
        }
        font {
            pixelSize: 15
            weight: Font.Bold
        }
    }

    MouseArea {
        id: buttonArea
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: {
            if (actionButton.buttonType === "buy") {
                if (postsDelegate.delegateType === "newGames") {
                    JS.orderGame(itemTitle.text, JS.admin.username, profileButton.label, itemPrice.text)
                    messageDialog.open()
                } else if (postsDelegate.delegateType === "usedGames") {
                    JS.orderGame(itemTitle.text, sellerUsername.text, profileButton.label, itemPrice.text)
                    messageDialog.open()
                }
            } else {
                requestsList.model.remove(index)
                messageDialog.open()
                JS.sellGame(itemID.text)
            }
        }
    }
}