import QtQuick
import QtQuick.Controls
import QtQuick.LocalStorage
import QtQuick.Dialogs
import "../database_functions.js" as JS

Component {

    Item {
        width: postsDelegate.delegateType === "profile" ? postsList.width : postsList.cellWidth - 50
        height: 250

        // HEADER
        Rectangle {
            id: itemHeader
            width: parent.width - 20
            height: 50
            color:"#5773ff"
            anchors {
                top: parent.top
                left: parent.left
            }

            // TITLE
            Text {
                id: itemTitle
                text: title
                color: "white"
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

            // DELETE BUTTON
            Rectangle {
                id: deleteButton
                visible: postsDelegate.delegateType === "profile" ? true: false
                width: parent.height - 5
                height: parent.height - 5
                radius: 50
                anchors {
                    verticalCenter: parent.verticalCenter
                    right: parent.right
                    rightMargin: 5
                }
                color: deleteButtonArea.containsMouse ? "#fe413c" : "transparent"

                Image {
                    source: "../icons/deleteIcon.png"
                    anchors.centerIn: parent
                }

                MouseArea {
                    id: deleteButtonArea
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        postsList.model.remove(index)
                        JS.deletePost(itemID.text);
                    }
                }
            }
        }

        // BODY
        Rectangle {
            width: parent.width - 20
            height: 200
            color: "#18181d"
            anchors {
                top: itemHeader.bottom
                left: parent.left
            }

            // GENRE
            Text {
                id: itemGenre
                text: "<b>Žanr:</b> " + genre
                color: "white"
                anchors {
                    top: parent.top
                    left: parent.left
                    margins: 10
                }
                font.pixelSize: 15
            }

            // DESCRIPTION
            Text {
                id: itemDescription
                text: "<b>Opis:</b> " + description
                color: "white"
                wrapMode: Text.Wrap
                anchors {
                    top: itemGenre.bottom
                    left: parent.left
                    right: parent.right
                    margins: 10
                }
                font.pixelSize: 15
            }

            // SELLER
            Text {
                id: sellerLabel
                visible: postsDelegate.delegateType === "usedGames" ? true : false
                text: "<b>Prodavač: </b>"
                color: "white"
                font.pixelSize: 15
                anchors {
                    verticalCenter: actionButton.verticalCenter
                    left: parent.left
                    margins: 10
                }
            }
            Text {
                id: sellerUsername
                visible: postsDelegate.delegateType === "usedGames" ? true : false
                text: seller
                color: "white"
                font.pixelSize: 15
                anchors {
                    verticalCenter: sellerLabel.verticalCenter
                    left: sellerLabel.right
                }
            }

            // PRICE
            Text {
                text: "<b>Cijena:</b> " + price + " HRK"
                visible: postsDelegate.delegateType === "profile" ? true : false
                color: "white"
                font.pixelSize: 15
                anchors {
                    bottom: parent.bottom
                    left: parent.left
                    margins: 10
                }
            }

            // BUY BUTTON
            ActionButton {
                id: actionButton
                property string buttonType: "buy"

            }
        }
    }
}