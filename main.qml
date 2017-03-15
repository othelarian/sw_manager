import QtQuick 2.7
import QtQuick.Window 2.2

import QtQuick.Controls 1.4

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("SW manager")

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
        highlight: Rectangle { color: "red"; width: 10; height: 10; x: 5; y: selectList.currentItem.y }
    }

    // dice launcher

    Text {
        x: 60
        y: 10
        text: selectList.currentIndex
    }

    // deck manager

    //


    // output
    ListModel {
        id: outListModel
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
        ListElement { value: "test" }
        ListElement { value: "test" }
        ListElement { value: "test" }
        ListElement { value: "test" }
    }

    ScrollView {
        x: 5; y: 150
        width: 180
        height: 100
        ListView {
            id: outputList
            model: outListModel
            delegate: Rectangle {
                width: 130
                height: 15
                color: "#3cf"
                Text {
                    anchors.centerIn: parent
                    text: value
                }
            }
        }
    }
}
