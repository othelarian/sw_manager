import QtQuick 2.8
import QtQuick.Controls 2.1

Item {
    anchors.top: parent.top; anchors.topMargin: 50
    anchors.left: parent.left; anchors.leftMargin: 10
    // functions
    function rollDice() {
        //
        //
    }
    // elements
    Row {
        spacing: 10
        // dice form
        Grid {
            id: diceForm
            columns: 2
            spacing: 4
            Label { text: "Number of dice:" }
            SpinBox {
                id: nbdice
                value: 1; from: 1; to: 100
                height: gameScreen.btnheight; editable: true
                font.pointSize: 12
                validator: IntValidator { bottom: 1; top: 100 }
            }
            Label { text: "Bonus/Malus:" }
            SpinBox {
                id: bonusdice
                value: 0; from: -100; to: 100
                height: gameScreen.btnheight; editable: true
                font.pointSize: 12
                validator: IntValidator { bottom: -100; top: 100 }
            }
            Button {
                height: gameScreen.btnheight
                text: "Roll"
                onClicked: { rollDice() }
            }
            CheckBox {
                id: acedice
                height: gameScreen.btnheight
                text: "Ace"
                indicator: Rectangle {
                    color: acedice.checked ? "#2af" : "white"
                    border.color: "black"; border.width: 1
                    width: gameScreen-2; height: gameScreen-2
                }
            }
        }
        // dice output
        ListModel { id: diceOutputModel }
        ListView {
            id: diceOutputView
            interactive: true
            spacing: 4
            //model: null
            //
            delegate: Row {
                property int order: id
                anchors.horizontalCenter: parent.horizontalCenter
                Rectangle {
                    //
                    //
                }
                //
                Button {
                    //
                    //
                }
            }
        }
    }
}
