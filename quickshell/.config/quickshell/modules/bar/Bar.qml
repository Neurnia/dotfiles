import Quickshell

import "components"

PanelWindow {
    anchors {
        top: true
        left: true
        right: true
    }
    implicitHeight: 25
    color: "transparent"

    Power {
        id: power
        anchors.right: parent.right
    }

    Clock {
        anchors.right: power.left
        anchors.rightMargin: 5
    }

    Workspaces {
        height: parent.height
        anchors.left: parent.left
    }
}
