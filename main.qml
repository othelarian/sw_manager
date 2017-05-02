import QtQuick 2.8
import QtQuick.Window 2.2
import QtQuick.Controls 2.1
import QtQuick.Dialogs 1.2 as D

import "Screens"

import "Scripts/core.js" as Core

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
    function gameStackChange(screen) { Core.gameStackChange(screen) }
    function gameStackSeparate(screen) { Core.gameStackSeparate(screen) }
    function gameStackReintegrate(screen) { Core.gameStackReintegrate(screen) }
    // main stack
    StackView {
        id: mainStack
        anchors.fill: parent
        initialItem: welcomeView
        // welcome screen
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
            property int btnwidth: 80
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
                GameScreen { id: extrasScreen; title: "Bestiary"; link: "extras"; ExtrasScreen { id: extrasIn1 } }
                GameScreen { id: locationsScreen; title: "Locations"; link: "locations"; LocationsScreen { id: locationsIn1 } }
                GameScreen { id: historyScreen; title: "History"; link: "history"; HistoryScreen { id: historyIn1 } }
                GameScreen { id: storiesScreen; title: "Stories"; link: "stories"; StoriesScreen { id: storiesIn1 } }
                GameScreen { id: sessionsScreen; title: "Sessions"; link: "sessions"; SessionsScreen { id: sessionsIn1 } }
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
                    onClicked: { Core.gameStackChange("diceroller") }
                }
                Button {
                    width: gameScreen.btnwidth; height: gameScreen.btnheight
                    text: "Deck"
                    onClicked: { Core.gameStackChange("deck") }
                }
                Button {
                    width: gameScreen.btnwidth; height: gameScreen.btnheight
                    text: "Rules"
                    onClicked: { Core.gameStackChange("rules") }
                }
                Button {
                    width: gameScreen.btnwidth; height: gameScreen.btnheight
                    text: "Chars"
                    onClicked: { Core.gameStackChange("chars") }
                }
                Button {
                    width: gameScreen.btnwidth; height: gameScreen.btnheight
                    text: "Bestiary"
                    onClicked: { Core.gameStackChange("extras") }
                }
                Button {
                    width: gameScreen.btnwidth; height: gameScreen.btnheight
                    text: "Locations"
                    onClicked: { Core.gameStackChange("locations") }
                }
                Button {
                    width: gameScreen.btnwidth; height: gameScreen.btnheight
                    text: "History"
                    onClicked: { Core.gameStackChange("history") }
                }
                Button {
                    width: gameScreen.btnwidth; height: gameScreen.btnheight
                    text: "Stories"
                    onClicked: { Core.gameStackChange("stories") }
                }
                Button {
                    width: gameScreen.btnwidth; height: gameScreen.btnheight
                    text: "Sessions"
                    onClicked: { Core.gameStackChange("sessions") }
                }
                Button {
                    width: gameScreen.btnwidth;height: gameScreen.btnheight
                    text: "Close"
                    onClicked: { Core.closegame() }
                }
            }
        }
    }
    // game screens separated
    WindowScreen { id: dicerollerWin; title: "Dice Roller"; link: "diceroller"; DiceRollerScreen { id: dicerollerIn2 } }
    WindowScreen { id: deckWin; title: "Deck"; link: "deck"; DeckScreen { id: deckIn2 } }
    WindowScreen { id: rulesWin; title: "Rules"; link: "rules"; RulesScreen { id: rulesIn2 } }
    WindowScreen { id: charsWin; title: "Characters"; link: "chars"; CharsScreen { id: charsIn2 } }
    WindowScreen { id: extrasWin; title: "Bestiary"; link: "extras"; ExtrasScreen { id: extrasIn2 } }
    WindowScreen { id: locationsWin; title: "Locations"; link: "locations"; LocationsScreen { id: locationsIn2 } }
    WindowScreen { id: historyWin; title: "History"; link: "history"; HistoryScreen { id: historyIn2 } }
    WindowScreen { id: storiesWin; title: "Stories"; link: "stories"; StoriesScreen { id: storiesIn2 } }
    WindowScreen { id: sessionsWin; title: "Sessions"; link: "sessions"; SessionsScreen { id: sessionsIn2 } }
    // select / create database dialog
    D.FileDialog {
        id: dbDialog
        title: ""; folder: shortcuts.home
        onAccepted: {
            dbpath = fileUrl
            if (createdbStatus) nameDialog.open()
            else Core.loadgame()
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
            Core.loadgame()
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
