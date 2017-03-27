import QtQuick 2.8
import QtQuick.Window 2.2
import QtQuick.Controls 2.1
import QtQuick.Dialogs 1.2 as D

import "Screens"

Window {
    id: root
    visible: true
    width: 640; minimumWidth: 640
    height: 480; minimumHeight: 480
    title: "Savage Worlds Manager"
    onClosing: { if (loaded) swmdb.closeDatabase() }
    // properties
    property bool createdbStatus
    property string dbpath
    property bool loaded: false
    // functions
    function loadgame() {
        swmdb.openDatabase(dbpath,createdbStatus)
        var infos = swmdb.getInfos()
        //
        // TODO : parse the infos
        //
        gameTitle.text = infos
        infosIn1.titleLab = infos
        //
        loaded = true
        mainStack.push(gameScreen)
    }
    function gameStackChange(screen) {
        // initialize a game screen if needed
        if (gameStack.screenPop[screen] === -1) {
            //
            // TODO : call the init
            //
            switch (screen) {
            case "diceroller": dicerollerIn1.initDice(); dicerollerIn2.initDice(); break
                //
            }
            //
            //
            gameStack.screenPop[screen] = 0
        }
        // open / close a game screen
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
        if (gameStack.screenPop[screen] === 2) return
        else if (gameStack.screenPop[screen] == 1) gameStackChange(screen)
        gameStack.screenPop[screen] = 2
        switch (screen) {
        case "diceroller": dicerollerWin.show(); break
        case "deck": deckWin.show(); break
        case "rules": rulesWin.show(); break
        case "chars": charsWin.show(); break
            //
        }
    }
    function gameStackReintegrate(screen) { gameStack.screenPop[screen] = 0 }
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
            Label {
                id: gameTitle
                x: 10; y: 10; text: ""
                font.pointSize: 20; font.bold: true
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
                    "diceroller": -1, "deck": -1, "rules": -1,
                    "chars": -1, "extras": -1, "location": -1,
                    "history": -1, "stories": -1, "sessions": -1
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
                // game screens
                GameScreen { id: gameinfosScreen; title: "Game infos"; InfosScreen { id: infosIn1 } }
                GameScreen { id: dicerollerScreen; title: "Dice Roller"; link: "diceroller"; DiceRollerScreen { id: dicerollerIn1 } }
                GameScreen { id: deckScreen; title: "Deck"; link: "deck"; DeckScreen { id: deckIn1 } }
                GameScreen { id: rulesScreen; title: "Rules"; link: "rules"; RulesScreen { id: rulesIn1 } }
                GameScreen { id: charsScreen; title: "Characters"; link: "chars"; CharsScreen { id: charsIn1 } }
                GameScreen {
                    id: extrasScreen
                    title: "Bestiary"
                    //
                }
                GameScreen {
                    id: locationScreen
                    title: "Locations"
                    //
                }
                GameScreen {
                    id: historyScreen
                    title: "History"
                    //
                }
                GameScreen {
                    id: storiesScreen
                    title: "Stories"
                    //
                }
                GameScreen {
                    id: sessionsScreen
                    title: "Sessions"
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
                    onClicked: { gameStackChange("extras") }
                }
                Button {
                    width: gameScreen.btnwidth; height: gameScreen.btnheight
                    text: "Location"
                    onClicked: { gameStackChange("location") }
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
                    onClicked: {
                        if (gameStack.screenPop.diceroller === 2) dicerollerWin.close()
                        if (gameStack.screenPop.deck === 2) deckWin.close()
                        if (gameStack.screenPop.rules === 2) rulesWin.close()
                        if (gameStack.screenPop.chars === 2) charsWin.close()
                        //
                        // TODO : close all opened window
                        //
                        var lstlinks = ["diceroller","deck","rules",
                                        "chars","extras","location",
                                        "history","stories","sessions"]
                        for (var i=0;i<lstlinks.length;i++) {
                            if (gameStack.screenPop[lstlinks[i]] == 1) gameStackChange(lstlinks[i])
                            gameStack.screenPop[lstlinks[i]] = -1
                        }
                        swmdb.closeDatabase(); loaded = false; mainStack.pop()
                    }
                }
            }
        }
    }
    // game screens separated
    WindowScreen { id: dicerollerWin; title: "Dice Roller"; link: "diceroller"; DiceRollerScreen { id: dicerollerIn2 } }
    WindowScreen { id: deckWin; title: "Deck"; link: "deck"; DeckScreen { id: deckIn2 } }
    WindowScreen { id: rulesWin; title: "Rules"; link: "rules"; RulesScreen { id: rulesIn2 } }
    WindowScreen { id: charsWin; title: "Characters"; link: "chars"; CharsScreen { id: charsIn2 } }
    //
    // TODO : add the other wins
    //
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
