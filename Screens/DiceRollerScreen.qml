import QtQuick 2.8
import QtQuick.Controls 2.1

Item {
    anchors.top: parent.top; anchors.topMargin: 50
    anchors.left: parent.left; anchors.leftMargin: 10
    // functions
    function initDice() {
        //
        console.log("init dice roller")
        //
        var params = swmdb.getDiceroller().split(",")
        //
        nbdice.value = parseInt(params[0])
        bonusdice.value = parseInt(params[1])
        //
        selectordice.currentIndex = parseInt(params[2])
        //
        console.log(params)
        //
    }
    function changeDice(label,value) { swmdb.setDiceroller(label,value) }
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
                font.pointSize: 10
                validator: IntValidator { bottom: 1; top: 100 }
                onValueChanged: { changeDice("nbdice",value) }
            }
            Label { text: "Bonus/Malus:" }
            SpinBox {
                id: bonusdice
                value: 0; from: -100; to: 100
                height: gameScreen.btnheight; editable: true
                font.pointSize: 10
                validator: IntValidator { bottom: -100; top: 100 }
                onValueChanged: { changeDice("bonusdice",value) }
            }
            ComboBox {
                id: selectordice
                width: 90; height: gameScreen.btnheight
                model: ["d2","d3","d4","d6","d8","d10","d12","d20","d100"]
                onActivated: {
                    //
                    //
                }
            }
            CheckBox {
                id: acedice
                height: gameScreen.btnheight
                text: "Ace"
                indicator: Rectangle {
                    color: acedice.checked ? "#2af" : "white"
                    border.color: "black"; border.width: 1
                    width: gameScreen.btnheight-2
                    height: gameScreen.btnheight-2
                }
                onCheckedChanged: {
                    //
                    console.log(checked)
                    //
                    //
                }
            }
            Button {
                height: gameScreen.btnheight
                text: "Roll"
                onClicked: { rollDice() }
            }
            Button {
                //
                height: gameScreen.btnheight
                //
                text: "Clear"
                //
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
