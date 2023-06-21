import QtQuick
import QtQuick.Controls
import QtQuick.LocalStorage
import "../database_functions.js" as JS


Component {
    
    Item {
        width: requestsList.width
        height: 120

        // HEADER
        Rectangle {
            id: itemHeader
            width: parent.width - 20
            height: 40
            color: status ? "#ffbc2c": "#5773ff"
            anchors {
                top: parent.top
                left: parent.left
            }

            // TITLE
            Text {
                id: itemTitle
                text: title
                color: status ? "#18181d": "white"
                font {
                    pixelSize: 20
                    weight: Font.Bold
                }
                anchors {
                    verticalCenter: parent.verticalCenter
                    left: parent.left
                    margins: 10
                }
            }

            // ID
            Text {
                id: itemID
                text: id
                visible: false
            }

            // DELETE ACCEPTED
            Text {
                visible: status ? true: false
                text: "X"
                color: "#18181d"
                font {
                    pixelSize: 20
                    weight: Font.Bold
                }
                anchors {
                    verticalCenter: parent.verticalCenter
                    right: parent.right
                    rightMargin: 10
                }

                MouseArea {
                    id: deleteOrder
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        ordersList.model.remove(index)
                        JS.deleteOrder(itemID.text)
                    }
                }
            }
        }

        // BODY
        Rectangle {
            width: parent.width - 20
            height: 80
            color: "#18181d"
            anchors {
                top: itemHeader.bottom
                left: parent.left
            }

            // BUYER/SELLER LABEL
            Text {
                id: usernameLabel
                text: seller === profileButton.label ? "<b>Kupac: </b>" : "<b>Prodavač: </b>"
                color: "white"
                font.pixelSize: 15
                anchors {
                    top: parent.top
                    left: parent.left
                    margins: 10
                }
            }

            // BUYER/SELLER
            Text {
                id: username
                text: seller === profileButton.label ? buyer : seller
                color: "white"
                font.pixelSize: 15
                anchors {
                    verticalCenter: usernameLabel.verticalCenter
                    left: usernameLabel.right
                }
            }

            // PRICE LABEL
            Text {
                id: priceLabel
                text: "<b>Cijena: </b>"
                color: "white"
                font.pixelSize: 15
                anchors {
                    top: usernameLabel.bottom
                    left: parent.left
                    margins: 10
                }
            }

            // PRICE
            Text {
                text: price + " HRK"
                color: "white"
                font.pixelSize: 15
                anchors {
                    verticalCenter: priceLabel.verticalCenter
                    left: priceLabel.right
                }
            }

            // SELL BUTTON
            ActionButton {
                id: actionButton
                property string buttonType: "sell"
            }
        }
    }
}