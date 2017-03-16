import QtQuick 2.7
import QtQuick.Window 2.2

//import QtQuick.Controls 1.4
import QtQuick.Controls 2.1

Window {
    id: root
    visible: true
    width: 640
    height: 480
    title: qsTr("SW manager")

    property variant diceWin

    Rectangle {
        x: 300; y: 10
        width: 40; height: 40
        color: "red"
        MouseArea {
            anchors.fill: parent
            onClicked: {
                var component = Qt.createComponent("Items/SWDiceWindow.qml")
                diceWin = component.createObject(root)
                diceWin.show()
            }
        }
    }

    // number of dice selector
    ListModel {
        id: nbListModel
        ListElement { name: "1"; value: 1; state: false }
        ListElement { name: "2"; value: 2; state: false }
        ListElement { name: "3"; value: 3; state: false }
        ListElement { name: "4"; value: 4; state: false }
        ListElement { name: "5"; value: 5; state: false }
        ListElement { name: "6"; value: 6; state: false }
        ListElement { name: "7"; value: 7; state: false }
        ListElement { name: "8"; value: 8; state: false }
        ListElement { name: "9"; value: 9; state: false }
    }

    ListView {
        id: selectList
        x: 5; y: 5; height: 140
        visible: false
        model: nbListModel
        delegate: Rectangle {
            width: 20
            height: 15
            color: "#3cf"
            MouseArea {
                anchors.fill: parent
                onClicked: selectList.currentIndex = value-1
            }
            Text {
                anchors.centerIn: parent
                text: name
            }
        }
        highlight: Rectangle { color: "#fc3"; width: 10; height: 10; x: 5; y: selectList.currentItem.y }
    }

    // dice launcher

    Text {
        x: 60
        y: 10
        text: selectList.currentIndex
    }

    // deck manager

    //

    // buttons

    // output
    ListView {
        id: outputList
        x: 5
        y: 180
        width: 322
        height: 170
        interactive: true
        keyNavigationWraps: false
        //clip: true
        //scale: 0.01
        spacing: 2
        model: outListModel
        delegate: Rectangle {
            width: 130; height: 15
            color: "#3cf"
            Text { text: value }
        }
    }

    Column {
        x: 5
        y: 5
        width: 217
        height: 225
        spacing: 2

        Row {
            spacing: 2
            Label {
                id: nbDiceLab
                text: qsTr("Nb dice :")
            }

            SpinBox {
                id: nbDiceSpinBox
                width: 110
                height: 20
            }
            //
            // clear the output
            //
            //
            // draw a card
            //
            // shuffle the deck
            //
            //
            //
            //
        }

        Row {
            width: 200
            height: 400
            spacing: 2

            Button {
                text: qsTr("Clear")
            }

            Button {
                id: button1
                text: qsTr("Button")
            }
        }
    }

    ListModel {
        id: outListModel
        ListElement { value: "test" }
        ListElement { value: "test" }
        ListElement { value: "test of a very long string, with a lot of dice : test" }
        ListElement { value: "6,12,34,21,67,7,4 -23 = XX (7dX-23)" }
        ListElement { value: "test" }
        ListElement { value: "test" }
        ListElement { value: "test" }
        ListElement { value: "test" }
        ListElement { value: "test" }
        ListElement { value: "test" }
        ListElement { value: "test" }
        ListElement { value: "test" }
        ListElement { value: "test" }
        ListElement { value: "test" }
        ListElement { value: "test" }
        ListElement { value: "test" }
        ListElement { value: "test" }
    }

    Grid {
        id: grid
        x: 5
        y: 5
        width: 110
        height: 150
        spacing: 3
        columns: 2

        Label {
            id: label1
            text: qsTr("Label")
        }

        SpinBox {
            id: spinBox1
            width: 110
            height: 20
        }
    }



}
