import QtQuick 2.8
import QtQuick.Controls 2.1

Item {
    anchors.top: parent.top; anchors.topMargin: 50
    anchors.left: parent.left; anchors.leftMargin: 10
    // properties
    property string titleLab: ""
    property bool titleEdit: false
    property int labWidth: 160
    // functions
    function titleChange() {
        titleLab = titleField.text
        gameTitle.text = titleField.text
        swmdb.setInfos("title",titleField.text)
        titleEdit = false
    }
    // elements
    Column {
        spacing: 4
        Row {
            spacing: 4
            Label { text: "Name of the game:"; width: labWidth }
            Label { text: titleLab; visible: !titleEdit }
            TextField {
                id: titleField
                visible: titleEdit
                height: gameScreen.btnheight+2; width: 120
            }
            Button {
                visible: !titleEdit
                height: gameScreen.btnheight
                width: gameScreen.btnwidth
                text: "Edit"
                onClicked: {
                    titleField.text = titleLab
                    titleEdit = true
                }
            }
            Button {
                visible: titleEdit
                height: gameScreen.btnheight
                width: gameScreen.btnwidth
                text: "Valid"
                onClicked: { titleChange() }
            }
            Button {
                visible: titleEdit
                height: gameScreen.btnheight
                width: gameScreen.btnwidth
                text: "Cancel"
                onClicked: { titleEdit = false }
            }
        }
    }
    //
    // TODO : number of characters + Access
    // TODO : number of sessions + access
    //
}
