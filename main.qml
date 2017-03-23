import QtQuick 2.8
import QtQuick.Window 2.2
import QtQuick.Controls 2.1
import QtQuick.Dialogs 1.2 as D

import "Screens"

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
    function gameStackChange(screen) {
        if (gameStack.screenPop[screen] === 0) {
            if (gameStack.screenPop.current != "") gameStack.screenPop[gameStack.screenPop.current] = 0
            gameStack.screenPop.current = screen
            gameStack.screenPop[screen] = 1
            switch (screen) {
            case "diceroller": gameStack.push(dicerollerScreen); break;
            case "deck": gameStack.push(deckScreen); break;
            case "rules": gameStack.push(rulesScreen); break;
            case "chars": gameStack.push(charsScreen); break;
            case "extras": gameStack.push(extrasScreen); break;
                //
                //
            }
        }
        else if (gameStack.screenPop[screen] === 1) {
            gameStack.screenPop.current = ""
            gameStack.screenPop[screen] = 0
            gameStack.pop(gameinfosScreen)
        }
    }
    function gameStackSeparate(screen) {
        //
        //
        //
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
                width: 300; padding: 40; spacing: 10
                anchors.horizontalCenter: parent.horizontalCenter
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
            property int btnwidth: 75
            property int btnheight: 22
            TextField {
                x: 10; y: 10
                placeholderText: "Untitled"
                //
                //
            }
            // game stack
            StackView {
                id: gameStack
                anchors.bottom: parent.bottom
                anchors.top: parent.top; anchors.topMargin: 60
                anchors.left: parent.left; anchors.leftMargin: 40
                anchors.right: parent.right; anchors.rightMargin: 100
                initialItem: gameinfosScreen
                // game screens properties
                property var screenPop: {
                    "current": "",
                    "diceroller": 0, "deck":0, "rules": 0, "chars": 0, "extras": 0,
                    "location": 0, "history": 0, "stories": 0, "sessions": 0
                }
                // animation of the stack
                Transition {
                    id: enterAnim
                    YAnimator {
                        from: (gameStack.mirrored ? -1 : 1)*gameStack.height
                        to: 0; duration: 400; easing.type: Easing.OutCubic
                    }
                }
                Transition {
                    id: exitAnim
                    YAnimator {
                        to: (gameStack.mirrored ? -1 : 1)*gameStack.height
                        from: 0; duration: 400; easing.type: Easing.OutCubic
                    }
                }
                pushEnter: enterAnim; pushExit: exitAnim
                popEnter: enterAnim; popExit: exitAnim
                // game infos screen
                GameScreen {
                    id: gameinfosScreen
                    title: "Game infos"
                    InfosScreen {}
                }
                // diceroller screen
                GameScreen {
                    id: dicerollerScreen
                    title: "Dice Roller"
                    btnUse: true; link: "diceroller"
                    DiceRollerScreen {}
                }
                // deck screen
                GameScreen {
                    //
                    id: deckScreen
                    title: "Deck"
                    btnUse: true; link: "deck"
                    //
                }
                // rules screen
                GameScreen {
                    //
                    id: rulesScreen
                    title: "Rules"
                    btnUse: true; link: "rules"
                    //
                }
                // characters screen
                GameScreen {
                    id: charsScreen
                    title: "Characters"
                    btnUse: true; link: "chars"
                    //
                }
                // extras screen
                GameScreen {
                    id: extrasScreen
                    title: "Bestiary"
                    //
                }
            }
            // right side menu
            Column {
                width: gameScreen.btnwidth
                anchors.right: parent.right; anchors.rightMargin: 0
                anchors.top: parent.top; anchors.topMargin: 20
                spacing: 4
                Button {
                    width: gameScreen.btnwidth; height: gameScreen.btnheight
                    text: "Roll"
                    onClicked: { gameStackChange("diceroller") }
                }
                Button {
                    width: gameScreen.btnwidth; height: gameScreen.btnheight
                    text: "Deck"
                    onClicked: { gameStackChange("deck") }
                }
                Button {
                    width: gameScreen.btnwidth; height: gameScreen.btnheight
                    text: "Rules"
                    onClicked: { gameStackChange("rules") }
                }
                Button {
                    width: gameScreen.btnwidth; height: gameScreen.btnheight
                    text: "Chars"
                    onClicked: { gameStackChange("chars") }
                }
                Button {
                    width: gameScreen.btnwidth; height: gameScreen.btnheight
                    text: "Bestiary"
                    //
                }
                Button {
                    width: gameScreen.btnwidth; height: gameScreen.btnheight
                    text: "Location"
                    //
                }
                Button {
                    width: gameScreen.btnwidth; height: gameScreen.btnheight
                    text: "History"
                    //
                }
                Button {
                    width: gameScreen.btnwidth; height: gameScreen.btnheight
                    text: "Stories"
                    //
                }
                Button {
                    width: gameScreen.btnwidth; height: gameScreen.btnheight
                    text: "Sessions"
                    //
                }
                Button {
                    width: gameScreen.btnwidth;height: gameScreen.btnheight
                    text: "Close"
                    onClicked: { swmdb.closeDatabase(); mainStack.pop() }
                }
            }
        }
    }
    // select / create database dialog
    D.FileDialog {
        id: dbDialog
        title: ""; folder: shortcuts.home
        onAccepted: {
            dbpath = fileUrl
            if (createdbStatus) nameDialog.open()
            else loadgame()
        }
    }
    // enter the name of the game file
    D.Dialog {
        id: nameDialog
        title: "Name of the game save"
        standardButtons: Dialog.Ok | Dialog.Cancel
        onAccepted: {
            if (nameTextField.text == "") return
            dbpath += "/"+nameTextField.text+".swdb"
            loadgame()
        }
        Column {
            spacing: 4
            Label { text: "Enter the name of the file :"; anchors.horizontalCenter: parent.horizontalCenter }
            Row {
                TextField { id: nameTextField; height: 25 }
                Label { text: ".swdb"; anchors.verticalCenter: parent.verticalCenter }
            }
        }
    }
}
