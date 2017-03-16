import QtQuick 2.0
import QtQuick.Window 2.1
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.1

Window {
    width: 400
    minimumWidth: width
    maximumWidth: width
    height: 400
    minimumHeight: height
    maximumHeight: height
    //
    Column {
        spacing: 2
        //width: 200
        //height: 200
        // nb dice row
        Row {
            spacing: 2
            //
            Text { text: "Nb dice :" }
            //
            SWSpinBox {
                //
                //
            }
            //
        }
        // buttons row
        Row {
            width: 200
            spacing: 2
            SWButton {
                btnValue: "Clear"
                function activate() { console.log("test clear") }
            }
            SWButton {
                btnValue: "Card"
            }
            SWButton {
                btnValue: "Shuffle"
            }

            //
        }
    }

    // essentials
    GroupBox {
        x: 300; y: 5
        title: "Essentials"
        GridLayout {
            columns: 2
            //
            SWButton {
                btnValue: "d2"
                //
            }
            SWButton {
                btnValue: "d3"
                //
            }

            //
            Text { text: "d2" }
            //Text { text: "d3" }
            //Text { text: "d4" }
            //
        }
        //
    }
    // output
    ListModel {
        id: outputModel
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
    ListView {
        x: 5; y: 180
        width: 320; height: 170
        interactive: true
        spacing: 2
        model: outputModel
        delegate: Rectangle {
            width: 320; height: 15
            color: "#3cf"
            Text { text: value }
        }
    }
}
