import QtQuick
import QtQuick.Controls
import QtQuick.LocalStorage
import QtQuick.Layouts
import "../database_functions.js" as JS

Rectangle {
	width: parent.width
	height: parent.height
	color: "#212529"
	anchors {
		top: parent.top
		left: parent.left
	}

	// NEW POST
	Rectangle {
		id: newPostButton
		width: 150
		height: 40
		radius: 10
		color: newPostButtonArea.containsMouse ? "#0adb81": "#08aa64"
		anchors {
			top: parent.top
			left: labelLine.left
			topMargin: 50
		}
		Text {
			id: newPostText
			text: "NOVA OBJAVA"
			anchors.centerIn: parent
			color: "white"
			font {
				pixelSize: 15
				weight: Font.Bold
			}
		}
		MouseArea {
			id: newPostButtonArea
			anchors.fill: parent
			hoverEnabled: true
			cursorShape: Qt.PointingHandCursor
			onClicked: newPostWindow.show()
		}
	}

	// LOGOUT
	Rectangle {
		id: logoutButton
		width: 150
		height: 40
		radius: 10
		color: logoutButtonArea.containsMouse ? "#fe6c67" : "#cb0801"
		anchors {
			top: newPostButton.top
			right: labelLine.right
		}
		MouseArea {
			anchors.fill: parent
			id: logoutButtonArea
			hoverEnabled: true
			cursorShape: Qt.PointingHandCursor
			onClicked: {
				view.push("login.qml")
				JS.logoutUser(profileButton.label)
			}
		}
		Text {
			text: "ODJAVA"
			anchors.centerIn: parent
			color: "white"
			font {
				pixelSize: 15
				weight: Font.Bold
			}
		}
	}

	// POSTS LABEL
	Text {
		id: postsLabel
		text: "MOJE OBJAVE"
		color: "white"
		font {
			pixelSize: 20
			weight: Font.Bold
		}
		anchors {
			top: newPostButton.bottom
			left: postsContainer.left
			topMargin: 30
		}
	}
	Rectangle {
		id: labelLine
		height: 5
		width: postsContainer.width
		color: "#ffbc2c"
		anchors {
			top: postsLabel.bottom
			left: postsLabel.left
			topMargin: 5
		}
	}

	PostsDelegate {
		id: postsDelegate
		property string delegateType: "profile"
	}

	Rectangle {
		id: postsContainer
		color: "transparent"
		width: parent.width - 500
		height: 600
		anchors {
			horizontalCenter: parent.horizontalCenter
			top: labelLine.bottom
			topMargin: 10
		}

		ListView {
			id: postsList
			anchors {
				fill: parent
			}
			spacing: 20
			boundsBehavior: Flickable.StopAtBounds
			clip: true

			ScrollIndicator.vertical: CustomScrollIndicator {}

			model: ListModel {
				id: postsModel
				Component.onCompleted: JS.getAllUserPosts("user", postsList, profileButton.label)
			}

			delegate: postsDelegate
		}
	}

	NewGameForm {
		id: newPostWindow
	}
}