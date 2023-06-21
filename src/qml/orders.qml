import QtQuick
import QtQuick.Controls
import QtQuick.LocalStorage
import "../database_functions.js" as JS

Rectangle {
	width: parent.width
	height: parent.height
	color: "#212529"
	anchors {
		top: parent.top
		left: parent.left
	}

	Text {
		id: requestsLabel
		text: "ZAHTJEVI ZA PRODAJU"
		color: "white"
		font {
			pixelSize: 20
			weight: Font.Bold
		}
		anchors {
			top: parent.top
			left: requestsContainer.left
			topMargin: 50
		}
	}

	Rectangle {
		width: requestsContainer.width
		height: 5
		color: "#ffbc2c"
		anchors {
			top: requestsLabel.bottom
			left: requestsLabel.left
			topMargin: 5
		}
	}

	Text {
		id: ordersLabel
		text: "MOJE NARUDŽBE"
		color: "white"
		font {
			pixelSize: 20
			weight: Font.Bold
		}
		anchors {
			top: parent.top
			left: ordersContainer.left
			topMargin: 50
		}
	}

	Rectangle {
		width: ordersContainer.width
		height: 5
		color: "#ffbc2c"
		anchors {
			top: ordersLabel.bottom
			left: ordersLabel.left
			topMargin: 5
		}
	}

	OrdersDelegate {
		id: requestsDelegate
	}

	Rectangle {
		id: requestsContainer
		width: (parent.width / 2) - 150
		height: parent.height - 150
		color: "#212529"
		anchors {
			top: requestsLabel.bottom
			left: parent.left
			topMargin: 20
			leftMargin: 100
		}

		ListView {
			id: requestsList
			anchors.fill: parent
			anchors.verticalCenter: parent.verticalCenter
			anchors.margins: 10
			spacing: 20
			boundsBehavior: Flickable.StopAtBounds
			clip: true

			ScrollIndicator.vertical: CustomScrollIndicator {}

			model: ListModel {
				id: requestsModel
				Component.onCompleted: JS.getMyRequests(requestsList, profileButton.label)
			}

			delegate: requestsDelegate
		}
	}

	OrdersDelegate {
		id: ordersDelegate
	}

	Rectangle {
		id: ordersContainer
		width: (parent.width / 2) - 150
		height: parent.height - 150
		color: "#212529"
		anchors {
			top: ordersLabel.bottom
			left: requestsContainer.right
			topMargin: 20
			leftMargin: 100
		}

		ListView {
			id: ordersList
			anchors.fill: parent
			anchors.verticalCenter: parent.verticalCenter
			anchors.margins: 10
			spacing: 20
			boundsBehavior: Flickable.StopAtBounds
			clip: true

			ScrollIndicator.vertical: CustomScrollIndicator {}

			model: ListModel {
				id: ordersModel
				Component.onCompleted: JS.getMyOrders(ordersList, profileButton.label)
			}

			delegate: ordersDelegate
		}
	}

	ConfirmationDialog {
		id: messageDialog
		dialogText: "Igra prodana!"
	}
}