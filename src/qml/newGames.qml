import QtQuick
import QtQuick.Controls
import QtQuick.LocalStorage
import QtQuick.Dialogs
import "../database_functions.js" as JS

Rectangle {
	width: parent.width
	height: parent.height
	color: "#212529"
	anchors {
		top: parent.top
		left: parent.left
	}

	PostsDelegate {
		id: postsDelegate
		property string delegateType: "newGames"
	}

	GridView {
		id: postsList
		anchors.fill: parent
		anchors.margins: 50
		cellHeight: 300
		cellWidth: 600
		boundsBehavior: Flickable.StopAtBounds
		clip: true

		ScrollIndicator.vertical: CustomScrollIndicator {}

		model: ListModel {
			id: postsModel
			Component.onCompleted: JS.getAllUserPosts("new", postsList, JS.admin.username)
		}

		delegate: postsDelegate
	}

	ConfirmationDialog {
		id: messageDialog
		dialogText: "Narudžba zaprimljena!"
	}
}