import QtQuick 2.7
import QtQuick.Window 2.2
import QtQuick.Controls 2.1
import QtQuick.Dialogs 1.2

Window {
    id: root
    visible: true
    width: 640
    minimumWidth: width
    height: 480
    minimumHeight: height
    title: "Savage Worlds Manager"

    //
    // TODO : button to open dice roller
    // TODO : welcome form
    //

    // properties
    property bool createdbStatus
    // main stack
    StackView {
        id: mainStack
        anchors.fill: parent
        initialItem: welcomeView
        // welcome screena
        Component {
            id: welcomeView
            Column {
                width: 300
                anchors.centerIn: mainStack
                padding: 40
                spacing: 10
                Label {
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.pointSize: 22
                    text: "Welcome to the Savage Worlds Manager!"
                }
                Row {
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 4
                    Button {
                        text: "Select a game"
                        onClicked: {
                            //
                            //mainStack.push(gameScreen)
                            //
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
        Component {
            id: gameScreen
            Text {
                text: "this is the game screen"
            }
        }
    }

    // select / create database dialog
    FileDialog {
        id: dbDialog
        title: ""
        folder: shortcuts.home
        onAccepted: {
            if (createdbStatus) {
                //
                // TODO : open new dialog to enter the name
                //
            }
            else {
                //
                //
                //
                mainStack.push(gameScreen)
            }
        }
    }
    // enter the name of the game file
    //
}
