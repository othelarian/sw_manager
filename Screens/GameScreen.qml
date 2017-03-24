import QtQuick 2.8
import QtQuick.Controls 2.1

Item {
    visible: false
    // properties
    property int btndim: 22
    property string title
    property string link: ""
    // elements
    Rectangle { color: "white"; border.color: "#bbb"; border.width: 1; anchors.fill: parent }
    Label { x: 10; y: 10; text: title; font.pointSize: 18 }
    Button {
        visible: link != ""
        width: btndim; height: btndim; text: "E"
        anchors.top: parent.top; anchors.topMargin: 10
        anchors.right: parent.right; anchors.rightMargin: 40
        onClicked: { gameStackSeparate(link) }
    }
    Button {
        visible: link != ""
        width: btndim; height: btndim; text: "X"
        anchors.top: parent.top; anchors.topMargin: 10
        anchors.right: parent.right; anchors.rightMargin: 10
        onClicked: { gameStackChange(link) }
    }
}
