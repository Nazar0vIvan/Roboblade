import QtQuick 2.15
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.2
import QtQuick.Extras 1.4
import QtQuick.Controls.Styles 1.4
import QtGraphicalEffects 1.15

import AppStyle 1.0

import "../.."

Item {
    id: root

    required property int fieldHeight
    required property var socket
    property alias topPadding: groupBox.topPadding
    property alias bottomPadding: groupBox.bottomPadding
    property alias spacing: groupBoxLayout.rowSpacing
    property alias title: groupBox.title

    GroupBox{
        id: groupBox
        anchors.fill: parent

        label: Label{
            color: AppStyle.foreground
            font: AppStyle.fonts.subtitle
            text: title
        }

        GridLayout{
            id: groupBoxLayout

            anchors.fill: parent
            rows: 3; columns: 2

            Label{
                Layout.preferredWidth: 70; Layout.preferredHeight: root.fieldHeight - 10
                verticalAlignment: Text.AlignVCenter
                text: qsTr("Local Port:")
                font: AppStyle.fonts.body
                color: AppStyle.foreground
                opacity: AppStyle.elevation.high
            }
            Label{
                id: portLabel
                Layout.preferredWidth: 60; Layout.preferredHeight: root.fieldHeight - 10
                Layout.alignment: Qt.AlignCenter
                text: socket.localPort === 0 ? "undefined" : parseInt(socket.localPort)
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font: AppStyle.networkView.socketControls.font
                color: portLabel.text === "undefined" ? "red" : AppStyle.foreground
                opacity: AppStyle.elevation.high
            }

            AppButton{
                id: bindButton

                Layout.preferredWidth: 70; Layout.preferredHeight: root.fieldHeight
                text: qsTr("Bind")
                enabled: portLabel.text === "undefined" ? false : true
                onClicked: { socket.callBindMethod(parseInt(portLabel.text)) }
            }
            StatusIndicator{
                id: bindStatusindicator
                Layout.preferredWidth: 60; Layout.preferredHeight: 20
                Layout.alignment: Qt.AlignCenter
                active: true
                color: socket.stateToString() === "BoundState" ? "green" : "red"
            }
            AppButton{
                id: openButton

                Layout.preferredWidth: 70; Layout.preferredHeight: root.fieldHeight
                text: socket.stateToString() === "ListetingState" ? "Close" : "Open"
                enabled: socket.stateToString() ===  "UnconnectedState" ? false : true
                onClicked: { socket.callOpenMethod() }

            }
            StatusIndicator{
                Layout.preferredWidth: 60; Layout.preferredHeight: 20
                Layout.alignment: Qt.AlignCenter
                active: true
                color: socket.stateToString() === "ListetingState" ? "green" : "red"
            }
        }
    }
    Connections{
        target: socket
        function onStateChanged(state){
            root.state = socket.stateToString()
        }
//        function onLocalPortChanged(port){
//            root.state
//        }
    }
    states:[
        State{
            name: "InitialState"
            PropertyChanges { target: portLabel; text: "undefined"; color: "red" }
            PropertyChanges { target: bindButton; enabled: false }
            PropertyChanges { target: openButton; enabled: false; text: "Open" }
        },

        State{
            name: "UnconnectedState"
            PropertyChanges { target: portLabel; text: parseInt(socket.localPort); color: AppStyle.foreground }
            PropertyChanges { target: bindButton; enabled: true }
            PropertyChanges { target: openButton; enabled: false; text: "Open" }
        },
        State{
            name: "BoundState"
            PropertyChanges { target: portLabel; text: parseInt(socket.localPort); color: AppStyle.foreground }
            PropertyChanges { target: bindButton }

            },
        State{
            name: "ListetingState"
            }
    ]
}

/*
InnerShadow {
    id: shadow
    anchors.fill: rect
    cached: true
    horizontalOffset: 2
    verticalOffset: -2
    radius: bindButton.pressed ? 16 : 1
    samples: 2*shadow.radius
    color: "#b0000000"
    smooth: true
    source: rect
}
*/
