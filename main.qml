import QtQuick 2.7
import QtQuick.Window 2.2
import QtQuick.Controls 2.1
import QtQuick.Dialogs 1.2

Window {
    id: root
    visible: true
    width: 640
    minimumWidth: 640
    height: 480
    minimumHeight: 480
    title: "Savage Worlds Manager"
    // properties
    property bool createdbStatus
    property string dbpath
    // functions
    function loadgame() {
        //
        swmdb.openDatabase(dbpath,createdbStatus)
        //
        //
        mainStack.push(gameScreen)
    }
    // main stack
    StackView {
        id: mainStack
        anchors.fill: parent
        initialItem: welcomeView
        // welcome screena
        Item {
            id: welcomeView
            Column {
                width: 300
                anchors.horizontalCenter: parent.horizontalCenter
                padding: 40
                spacing: 10
                Label {
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.pointSize: 22
                    text: "Welcome to the Savage Worlds Manager!"
                }
                // TODO : add the 5 last editing
                Row {
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 4
                    Button {
                        text: "Select a game"
                        onClicked: {
                            createdbStatus = false
                            dbDialog.title = "Select a game (.swdb)"
                            dbDialog.nameFilters = ["SWM game (*.swdb)"]
                            dbDialog.selectFolder = false
                            dbDialog.open()
                        }
                    }
                    Button {
                        text: "Create a game"
                        onClicked: {
                            createdbStatus = true
                            dbDialog.title = "Select a directory"
                            dbDialog.selectFolder = true
                            dbDialog.open()
                        }
                    }
                }
                Label {
                    id: errorLab
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: "red"; font.bold: true; text: ""
                }
            }
        }
        // game screen
        Item {
            id: gameScreen
            visible: false
            //
            //anchors.fill: parent
            //
            property int btnwidth: 60
            property int btnheight: 22
            TextField {
                x: 10; y: 10
                placeholderText: "Untitled"
            }
            // game stack
            StackView {
                id: gameStack
                anchors.bottom: parent.bottom
                anchors.top: parent.top; anchors.topMargin: 100
                anchors.left: parent.left; anchors.leftMargin: 50
                anchors.right: parent.right; anchors.rightMargin: 100
                initialItem: gameinfosScreen
                // game screens properties
                property bool dicerollerPop: false
                property bool deckPop: false
                property bool charsPop: false
                property bool extrasPop: false
                property bool locationPop: false
                property bool historyPop: false
                property bool storiesPop: false
                property bool sessionsPop: false
                // game infos screen
                Item {
                    id: gameinfosScreen
                    Rectangle {
                        color: "white"
                        border.color: "gray"
                        //border.
                    }
                    //
                    Text { text: "game infos" }
                    //
                }
                // diceroller screen
                Item {
                    id: dicerollerScreen
                    visible: false
                    //
                    //Rectangle { color: "red"; anchors.fill: parent }
                    //
                    //
                    Button {
                        width: gameScreen.btnheight; height: gameScreen.btnheight
                        text: "Close"
                        onClicked: {
                            //
                            gameStack.pop()
                            //
                        }
                    }
                }
                //
            }
            // right side menu
            Column {
                width: 60
                anchors.right: parent.right; anchors.rightMargin: 0
                anchors.top: parent.top; anchors.topMargin: 20
                spacing: 4
                Button {
                    width: gameScreen.btnwidth; height: gameScreen.btnheight
                    text: "Roll"
                    onClicked: {
                        //
                        gameStack.push(dicerollerScreen)
                        //
                    }
                }
                Button {
                    //
                    width: gameScreen.btnwidth; height: gameScreen.btnheight
                    text: "Deck"
                    //
                }
                Button {
                    //
                    width: gameScreen.btnwidth; height: gameScreen.btnheight
                    text: "Chars"
                    //
                }
                Button {
                    width: gameScreen.btnwidth;height: gameScreen.btnheight
                    text: "Close"
                    onClicked: {
                        //
                        mainStack.pop()
                        //
                    }
                }
            }
        }
    }
    // select / create database dialog
    FileDialog {
        id: dbDialog
        title: ""
        folder: shortcuts.home
        onAccepted: {
            dbpath = fileUrl
            if (createdbStatus) nameDialog.open()
            else loadgame()
        }
    }
    // enter the name of the game file
    Dialog {
        id: nameDialog
        title: "Name of the game save"
        standardButtons: Dialog.Ok | Dialog.Cancel
        onAccepted: {
            dbpath += "/"+nameTextField.text+".swdb"
            loadgame()
        }
        Column {
            spacing: 4
            Label { text: "Enter the name of the file :" }
            TextField { id: nameTextField }
        }
    }
}
