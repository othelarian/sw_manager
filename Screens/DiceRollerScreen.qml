import QtQuick 2.8
import QtQuick.Controls 2.1

Item {
    id: dicerollerItem
    anchors.top: parent.top; anchors.topMargin: 50
    anchors.left: parent.left; anchors.leftMargin: 10
    // properties
    property bool init
    // functions
    function initDice() {
        init = true
        var params = diceMgr.getParameters().split(",")
        nbdice.value = parseInt(params[0])
        bonusdice.value = parseInt(params[1])
        selectordice.currentIndex = parseInt(params[2])
        acedice.checked = (params[3] === "true")? true : false
        init = false
    }
    // dice form
    Grid {
        id: diceForm
        anchors.left: parent.left; anchors.leftMargin: 10
        anchors.top: parent.top; anchors.topMargin: 10
        columns: 2
        spacing: 4
        Label { text: "Number of dice:" }
        SpinBox {
            id: nbdice
            value: 1; from: 1; to: 100
            height: gameScreen.btnheight
            width: 100
            editable: true
            font.pointSize: 10
            validator: IntValidator { bottom: 1; top: 100 }
            onValueChanged: { if (!init) diceMgr.setParameter("nb",value) }
            up.indicator.width: 30
            down.indicator.width: 30
        }
        Label { text: "Bonus/Malus:" }
        SpinBox {
            id: bonusdice
            value: 0; from: -100; to: 100
            height: gameScreen.btnheight
            width: 100
            editable: true
            font.pointSize: 10
            validator: IntValidator { bottom: -100; top: 100 }
            onValueChanged: { if (!init) diceMgr.setParameter("bonus",value) }
            up.indicator.width: 30
            down.indicator.width: 30
        }
        ComboBox {
            id: selectordice
            width: 90; height: gameScreen.btnheight
            model: ["d2","d3","d4","d6","d8","d10","d12","d20","d100"]
            onActivated: { if (!init) diceMgr.setParameter("selector",currentIndex) }
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
            onCheckedChanged: { if (!init) diceMgr.setParameter("ace",(checked)? 1 : 0) }
        }
        Button {
              height: gameScreen.btnheight
              text: "Roll"
              onClicked: diceMgr.rollDice()
          }
        Button {
            height: gameScreen.btnheight
            text: "Clear"
            onClicked: diceMgr.clearOutput(true)
        }
    }
    // dice output
    ListView {
        id: diceOutputView
        x: 220; y: 20; width: 300; height: 350
        interactive: true
        spacing: 4
        model: diceMgr.outputs
        delegate: Row {
            anchors.horizontalCenter: parent.horizontalCenter
            Rectangle {
                width: 200
                height: 22
                color: "#f0f0f0"
                Text { x: 5; text: value; anchors.verticalCenter: parent.verticalCenter }
              }
              Button {
                  width: gameScreen.btnheight
                  height: gameScreen.btnheight
                  text: "X"
                  onClicked: diceMgr.removeOutput(index,outorder)
              }
          }
      }
}
