import QtQuick 2.15
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.15
import QtQml.Models 2.15

import AppStyle 1.0
import Components 1.0

ListView{
    id: root

    property int maxAvailableWidth: root.contentWidth - root.width
    property int maxAvailableHeight: root.contentHeight - root.height

    readonly property int _componentHeight: 30
    readonly property int _componentsSpacing: 10

    readonly property int _labelWidth: 150
    readonly property int _fieldWidth: 400
    readonly property int _componentSpacing: 0

    property var signals: new Map()

    signal krcLocalPortChanged(string port)
    signal krcPeerAddressChanged(string address)
    signal ftsLocalPortChanged(string port)
    signal ftsPeerAddressChanged(string address)
    signal houLocalPortChanged(string port)
    signal houPeerPortChanged(string port)
    signal vfdLocalPortChanged(string port)
    signal vfdPeerAddressChanged(string address)
    signal vfdPeerPortChanged(string port)

    onKrcLocalPortChanged:   { socketRSI.localPort = parseInt(port); console.log(port)} // root.networkView.krcLocalPort = port }
    onKrcPeerAddressChanged: { socketRSI.peerAddress = socketRSI.stringToHostAddress(address)}
    onFtsLocalPortChanged:   { socketRDT.localPort = parseInt(port); console.log(port) }
    onFtsPeerAddressChanged: { socketRDT.peerAddress = socketRDT.stringToHostAddress(address) } // BAD
    onHouLocalPortChanged:   { socketHou.localPort = parseInt(port); console.log(port) }
    onHouPeerPortChanged:    { socketHou.peerPort = parseInt(port) }
    onVfdLocalPortChanged:   { /*console.log(port)*/ }
    onVfdPeerAddressChanged: { /*console.log(address)*/ }
    onVfdPeerPortChanged:    { /*console.log(port)*/ }

    spacing: 20
    clip: true
    boundsBehavior: Flickable.StopAtBounds

    RegularExpressionValidator{ id: ipValidator; regularExpression: /^((?:[0-1]?[0-9]?[0-9]|2[0-4][0-9]|25[0-5])\.){0,3}(?:[0-1]?[0-9]?[0-9]|2[0-4][0-9]|25[0-5])$/ }
    IntValidator{ id: portValidator; bottom: 0; top: 99999 }

    // -> ObjectModel
    model: ObjectModel{

        // -> krc
        SettingsSection{
            id: rsiSettings

            width: root.width
            titleName: qsTr("RobotSensorInterface")
            componentHeight: _componentHeight; componentsSpacing: _componentsSpacing;
            labelWidth: _labelWidth; fieldWidth: _fieldWidth; componentSpacing: _componentSpacing
            components:[
                AppFormComponent{ id: uploadFile;      labelName: qsTr("Configuration File"); field: AppFileUpload{ fieldWidth: _fieldWidth; defaultTxt: qsTr("defined by Configuration File"); } },
                AppFormComponent{ id: krcLocalAddress; labelName: qsTr("Local Address");      field: AppTextField{ defaultTxt: qsTr("defined by Configuration File"); readOnly: true } },
                AppFormComponent{ id: krcLocalPort;    labelName: qsTr("Local Port");         field: AppTextField{ defaultTxt: qsTr("defined by Configuration File"); readOnly: true } },
                AppFormComponent{ id: krcOnlySend;     labelName: qsTr("ONLYSEND");           field: AppTextField{ defaultTxt: qsTr("defined by Configuration File"); readOnly: true } },
                AppFormComponent{ id: krcPeerAddress;  labelName: qsTr("Peer Address");       field: AppTextField{ text: qsTr("192.168.1.2");                         readOnly: true } }
            ]
        }
        // <- krc

        // -> fts
        SettingsSection{
            id: ftsSettings

            width: root.width
            titleName: qsTr("Force/Torque Sensor")
            componentHeight: _componentHeight; componentsSpacing: _componentsSpacing;
            labelWidth: _labelWidth; fieldWidth: _fieldWidth; componentSpacing: _componentSpacing
            components:[
                AppFormComponent{
                    id: ftsLocalPort
                    labelName: qsTr("Local Port");
                    field: AppTextField{
                        text: "59152"
                        validator: portValidator
                        onEditingFinished:{ signals.set(1, {signal: root.ftsLocalPortChanged, arg: text}) }
                    }
                },
                AppFormComponent{
                    id: ftsPeerAddress
                    labelName: qsTr("Peer Address")
                    field: AppTextField{
                        text: "192.168.1.3"
                        validator: ipValidator
                        onEditingFinished:{ signals.set(2, {signal: root.ftsPeerAddressChanged, arg: text}) }
                    }
                },
                AppFormComponent{
                    id: ftsPeerPort
                    labelName: qsTr("Peer Port")
                    field: AppTextField{ text: "49152"; borderWidth: 0; readOnly: true }
                }
            ]
        }
        // <-fts

        // -> hou
        SettingsSection{
            id: houSettings

            width: root.width
            titleName: qsTr("Houdini")
            componentHeight: _componentHeight; componentsSpacing: _componentsSpacing
            labelWidth: _labelWidth; fieldWidth: _fieldWidth; componentSpacing: _componentSpacing
            components:[
                AppFormComponent{
                    id: houLocalPort
                    labelName: qsTr("Local Port")
                    field: AppTextField{
                        text: "1111"
                        validator: portValidator
                        onEditingFinished:{ signals.set(3, {signal: root.houLocalPortChanged, arg: text}) }
                    }
                },
                AppFormComponent{
                    id: houPeerAddress
                    labelName: qsTr("Peer Address")
                    field: AppTextField{ text: "127.0.0.1"; borderWidth: 0; readOnly: true }
                },
                AppFormComponent{
                    id: houPeerPort
                    labelName: qsTr("Peer Port")
                    field: AppTextField{
                        text: "2222"
                        validator: portValidator
                        onEditingFinished:{ signals.set(4, {signal: root.houPeerPortChanged, arg: text}) }
                    }
                }
            ]
        }
        // <- hou

        // -> vfd
        SettingsSection{
            id: vfdSettings

            width: root.width
            titleName: qsTr("Variable Frequency Drive A65")
            componentHeight: _componentHeight; componentsSpacing: _componentsSpacing
            labelWidth: _labelWidth; fieldWidth: _fieldWidth; componentSpacing: _componentSpacing
            components:[
                AppFormComponent{
                    id: vfdLocalPort
                    labelName: qsTr("Local Port")
                    field: AppTextField{
                        text: qsTr("111111")
                        validator: portValidator
                        onEditingFinished:{ signals.set(5, {signal: root.vfdLocalPortChanged, arg: text}) }
                    }
                },
                AppFormComponent{
                    id: vfdPeerAddress

                    labelName: qsTr("Peer Address");
                    field: AppTextField{
                        text: qsTr("192.168.1.4")
                        validator: ipValidator
                        onEditingFinished:{ signals.set(6, {signal: vfdPeerAddressChanged, arg: text}) }
                    }
                },
                AppFormComponent{
                    id: vfdPeerPort

                    labelName: qsTr("Peer Port")
                    field: AppTextField{
                        text: qsTr("222222")
                        validator: portValidator
                        onEditingFinished:{ signals.set(7, {signal: root.vfdPeerPortChanged, arg: text}) }
                    }
                }
            ]
        }
        // <- vfd

    } // <- ObjectModel

    onContentYChanged: { vBar.adjustVBarIndicator() }

//    MouseArea{
//        id: rootMA

//        anchors.fill: parent
//        onWheel: wheel => { if (wheel.angleDelta.y > 0) vBar.decrease(); else vBar.increase() }

//        onClicked: mouse => { console.log("pressed"); mouse.accepted = true }
////        preventStealing: false
////        onClicked: mouse => { mouse.accepted = true }
////        onReleased: mouse => { mouse.accepted = true }
////        onPressed: mouse => { mouse.accepted = true }
////        hoverEnabled: true

//        propagateComposedEvents: true
//    }

    AppScrollBar{
        id: vBar

        view: root
        width: 8
        orientation: Qt.Vertical
        color: "transparent"

        iradius: vBar.width/2
        icolor: AppStyle.surface
        iopacity: 0.5
        iborderc: "gray"
        iborderw: 1
    }
}

