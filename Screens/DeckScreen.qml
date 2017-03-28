import QtQuick 2.8
import QtQuick.Controls 2.1

Item {
    anchors.top: parent.top; anchors.topMargin: 50
    anchors.left: parent.left; anchors.leftMargin: 10
    // functions
    function initDeck() {
        //
        console.log("init deck")
        //
    }
    // elements
    Row {
        spacing: 10
        // deck form
        Grid {
            id: deckForm
            //
            //
        }
        // deck output
        //
    }
}
