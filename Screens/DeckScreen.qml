import QtQuick 2.8
import QtQuick.Controls 2.1

Item {
    id: deckItem
    anchors.top: parent.top; anchors.topMargin: 50
    anchors.left: parent.left; anchors.leftMargin: 10
    // properties
    property bool init
    // functions
    function initDeck() {
        init = true
        //
        console.log("init deck")
        //
        var params = ""
        //
        init = false
    }
    // deck form
    Grid {
        id: deckForm
        anchors.left: parent.left; anchors.leftMargin: 10
        anchors.top: parent.top; anchors.topMargin: 10
        columns: 2
        spacing: 4
        //
        //
        Label {
            //
            text: "Number of cards:"
            //
        }
        SpinBox {
            //
            id: nbcard
            //
            value: 1; from: 1; to: 54
            height: gameScreen.btnheight
            width: 100
            editable: true
            font.pointSize: 10
            validator: IntValidator { bottom: 1; top: 54 }
            onValueChanged: {
                //
                if (!init) { }
                //
            }
            up.indicator.width: 30
            down.indicator.width: 30
        }
        Button {
            height: gameScreen.btnheight
            text: "Take"
            //
        }
        Button {
            height: gameScreen.btnheight
            text: "Shuffle"
            //
        }
    }
    // deck output
    ListView {
        id: deckOutputView
        x: 220; y: 20; width: 300; height: 350
        interactive: true
        spacing: 4
        //
        //
        //
    }
}
