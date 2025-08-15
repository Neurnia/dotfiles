import Quickshell
import Quickshell.Io
import QtQuick

PanelWindow {
    anchors {
        top: true
        left: true
        right: true
    }

    implicitHeight: 20

    Text {
        id: clock
        anchors.right: parent.right

        Process {
            id: dateProc

            command: ["date"]
            running: true
            stdout: StdioCollector {
                onStreamFinished: clock.text = this.text
            }
        }
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: dateProc.running = true
    }
}
