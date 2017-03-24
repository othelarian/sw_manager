import QtQuick 2.8
import QtQuick.Controls 2.1
import QtQuick.Window 2.2

Window {
    id: screenWin
    width: 500; minimumWidth: 500
    height: 420; minimumHeight: 420
    onClosing: { gameStackReintegrate(link) }
    // properties
    property int btndim: 22
    property string title
    property string link
    // elements
    Label { x: 10; y: 10; text: title; font.pointSize: 18 }
    Button {
        width: btndim; height: btndim; text: "X"
        anchors.top: parent.top; anchors.topMargin: 10
        anchors.right: parent.right; anchors.rightMargin: 10
        onClicked: { screenWin.close() }
    }
}
