import QtQuick
import Quickshell.Hyprland
import qs.components

Row {
    spacing: 3
    Repeater {
        model: Hyprland.workspaces
        Capsule {
            text: modelData.id
            width: 20
            radius: height / 4

            color: modelData.focused ? "#9084bfcf" : "#50487a87"

            border.color: hover.hovered ? "white" : "#80FFFFFF"
            HoverHandler {
                id: hover
            }

            MouseArea {
                anchors.fill: parent
                onClicked: Hyprland.dispatch(`workspace ${modelData.id}`)
            }
        }
    }
}
