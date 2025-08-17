import QtQuick

Rectangle {
    property string text

    height: parent.height
    width: content.width + 20
    radius: height / 2
    color: "#50487a87"
    border.color: "#80FFFFFF"
    border.width: 1

    Text {
        id: content
        anchors.centerIn: parent
        color: "white"
        font.family: "JetBrainsMono Nerd Font"
        text: parent.text
    }
}
