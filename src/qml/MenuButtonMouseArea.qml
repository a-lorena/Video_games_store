import QtQuick
import QtQuick.Controls


MouseArea {
    property string sourceFile: ""
    property var selectedButton: newGamesSelected

    anchors.fill: parent
    hoverEnabled: true
    cursorShape: Qt.PointingHandCursor
    onClicked: {
        pages.setSource(sourceFile)
        changeSelected(selectedButton)
    }
}
