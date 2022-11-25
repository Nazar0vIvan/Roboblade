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

    signal rsiConfigFileChanged
//    signal ftsLocalPortChanged
//    signal ftsPeerAddressChanged
//    signal houLocalPortChanged
//    signal houPeerPortChanged
//    signal vfdLocalPortChanged
//    signal vfdPeerAddressChanged
//    signal vfdPeerPortChanged

    onRsiConfigFileChanged:{
        socketRSI.localAddress = krcLocalAddress.field.text
        socketRSI.localPort = parseInt(krcLocalPort.field.text)
    }
//    onFtsLocalPortChanged:   { socketRDT.localPort = parseInt(port); console.log(port) }
//    onFtsPeerAddressChanged: { socketRDT.peerAddress = socketRDT.stringToHostAddress(address) } // BAD
//    onHouLocalPortChanged:   { socketHou.localPort = parseInt(port); console.log(port) }
//    onHouPeerPortChanged:    { socketHou.peerPort = parseInt(port) }
//    onVfdLocalPortChanged:   { /*console.log(port)*/ }
//    onVfdPeerAddressChanged: { /*console.log(address)*/ }
//    onVfdPeerPortChanged:    { /*console.log(port)*/ }

    spacing: 20
    clip: true
    boundsBehavior: Flickable.StopAtBounds

    RegularExpressionValidator{ id: ipValidator; regularExpression: /^((?:[0-1]?[0-9]?[0-9]|2[0-4][0-9]|25[0-5])\.){0,3}(?:[0-1]?[0-9]?[0-9]|2[0-4][0-9]|25[0-5])$/ }
    IntValidator{ id: portValidator; bottom: 0; top: 99999 }

    // -> ObjectModel
    model: ObjectModel{

        // -> rsi
        SettingsSection{
            id: rsiSettings

            width: root.width
            titleName: qsTr("Robot Sensor Interface")
            componentHeight: _componentHeight; componentsSpacing: _componentsSpacing
            labelWidth: _labelWidth; fieldWidth: _fieldWidth; componentSpacing: _componentSpacing
            components:[
                AppFormComponent{
                    id: uploadFile
                    labelName: qsTr("Configuration File")
                    field: AppFileUpload{ fieldWidth: _fieldWidth; defaultTxt: qsTr("defined by Configuration File") }
                },
                AppFormComponent{
                    id: krcLocalAddress
                    labelName: qsTr("Local Address")
                    field: AppTextField{ defaultTxt: qsTr("defined by Configuration File"); readOnly: true; enabled: false }
                },
                AppFormComponent{
                    id: krcLocalPort
                    labelName: qsTr("Local Port")
                    field: AppTextField{ defaultTxt: qsTr("defined by Configuration File"); readOnly: true; enabled: false }
                },
                AppFormComponent{
                    id: krcOnlySend
                    labelName: qsTr("ONLYSEND")
                    field: AppTextField{ defaultTxt: qsTr("defined by Configuration File"); readOnly: true; enabled: false }
                },
                AppFormComponent{
                    id: krcPeerAddress
                    labelName: qsTr("Peer Address")
                    field: AppTextField{ text: socketRSI.peerAddress; readOnly: true; enabled: false }
                }
            ]
        }
        // <- rsi

        // -> fts
        SettingsSection{
            id: ftsSettings

            width: root.width
            titleName: qsTr("Force/Torque Sensor")
            componentHeight: _componentHeight; componentsSpacing: _componentsSpacing;
            labelWidth: _labelWidth; fieldWidth: _fieldWidth; componentSpacing: _componentSpacing
            components:[
                AppFormComponent{
                    id: ftsLocalAddress
                    labelName: qsTr("Local Address");
                    field: AppTextField{
                        text: socketRDT.localAddress
                        borderWidth: 0
                        readOnly: true
                    }
                },
                AppFormComponent{
                    id: ftsLocalPort
                    labelName: qsTr("Local Port");
                    field: AppTextField{
                        text: socketRDT.localPort.toString()
                        validator: portValidator
                        onEditingFinished:{ signals.set(1, {signal: root.ftsLocalPortChanged, arg: text}) }
                    }
                },
                AppFormComponent{
                    id: ftsPeerAddress
                    labelName: qsTr("Peer Address")
                    field: AppTextField{
                        text: socketRDT.peerAddress
                        validator: ipValidator
                        onEditingFinished:{ signals.set(2, {signal: root.ftsPeerAddressChanged, arg: text}) }
                    }
                },
                AppFormComponent{
                    id: ftsPeerPort
                    labelName: qsTr("Peer Port")
                    field: AppTextField{
                        text: socketRDT.peerPort.toString()
                        borderWidth: 0
                        readOnly: true
                    }
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
                        text: socketHou.localPort
                        validator: portValidator
                        onEditingFinished:{ signals.set(3, {signal: root.houLocalPortChanged, arg: text}) }
                    }
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
                    id: vfdLocalAddress
                    labelName: qsTr("Local Address");
                    field: AppTextField{
                        text: socketVFDA65.localAddress
                        borderWidth: 0
                        readOnly: true
                    }
                },
                AppFormComponent{
                    id: vfdLocalPort
                    labelName: qsTr("Local Port")
                    field: AppTextField{
                        text: socketVFDA65.localPort
                        validator: portValidator
                        onEditingFinished:{ signals.set(5, {signal: root.vfdLocalPortChanged, arg: text}) }
                    }
                },
                AppFormComponent{
                    id: vfdPeerAddress

                    labelName: qsTr("Peer Address");
                    field: AppTextField{
                        text: socketVFDA65.peerAddress
                        validator: ipValidator
                        onEditingFinished:{ signals.set(6, {signal: vfdPeerAddressChanged, arg: text}) }
                    }
                },
                AppFormComponent{
                    id: vfdPeerPort

                    labelName: qsTr("Peer Port")
                    field: AppTextField{
                        text: socketVFDA65.peerPort
                        validator: portValidator
                        onEditingFinished:{ signals.set(7, {signal: root.vfdPeerPortChanged, arg: text}) }
                    }
                }
            ]
        }
        // <- vfd
    } // <- ObjectModel

    onContentYChanged: { vBar.adjustVBarIndicator() }

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

