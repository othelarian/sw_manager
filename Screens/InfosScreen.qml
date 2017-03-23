import QtQuick 2.8
import QtQuick.Controls 2.1

Item {
    anchors.top: parent.top; anchors.topMargin: 50
    anchors.left: parent.left; anchors.leftMargin: 10
    // properties
    property bool titleEdit: false
    // functions
    function titleChange() {
        if (titleEdit) {
            //
            //
            //
        }
        else {
            //
            //
        }
    }
    // elements
    Column {
        spacing: 4
        //
        Row {
            //
            Label {
                //
                //
            }
            //
        }
        //
        Label { text: "Name of the game:" }
        Label {
            //
            text: "Untitled"
            //
            visible: !titleEdit
            //
        }
        TextField {
            //
            visible: titleEdit
            //
        }
        Button {
            id: infosTitleBtn
            height: gameScreen.btnheight
            text: "Edit"
            onClicked: {
                //
                //
            }
        }
        //
    }
    //
    // TODO : number of characters + Access
    // TODO : number of sessions + access
    //
}
