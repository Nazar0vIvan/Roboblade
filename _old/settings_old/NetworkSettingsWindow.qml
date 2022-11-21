import QtQuick 2.15
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.2
import Qt.labs.settings 1.0
import QtQml.Models 2.15

import AppStyle 1.0

import "../../NetworkView"

Item{
    id: root

    readonly property int fieldHeight: 25
    property var signals: new Map()

    signal appIPAddressChanged(string address)
    signal krcLocalPortChanged(string port)
    signal krcIPAddressChanged(string address)
    signal vfdLocalPortChanged(string port)
    signal vfdIPAddressChanged(string address)
    signal vfdPeerPortChanged(string port)
    signal ftsLocalPortChanged(string port)
    signal ftsIPAddressChanged(string address)
    signal houLocalPortChanged(string port)
    signal houPeerPortChanged(string port)

    onAppIPAddressChanged: { /*console.log(address)*/ }
    onKrcLocalPortChanged: { socketRSI.localPort = parseInt(port); console.log(port)} //root.networkView.krcLocalPort = port }
    onKrcIPAddressChanged: { socketRSI.peerAddress = socketRSI.stringToHostAddress(address)}
    onVfdLocalPortChanged: { /*console.log(port)*/ }
    onVfdIPAddressChanged: { /*console.log(address)*/ }
    onVfdPeerPortChanged:  { /*console.log(port)*/ }
    onFtsLocalPortChanged: { socketRDT.localPort = parseInt(port); console.log(port) }
    onFtsIPAddressChanged: { socketRDT.peerAddress = socketRDT.stringToHostAddress(address) } // BAD
    onHouLocalPortChanged: { socketHou.localPort = parseInt(port); console.log(port) }
    onHouPeerPortChanged:  { socketHou.peerPort = parseInt(port) }

    RegExpValidator{
        id: ipValidator
        regExp: /^((?:[0-1]?[0-9]?[0-9]|2[0-4][0-9]|25[0-5])\.){0,3}(?:[0-1]?[0-9]?[0-9]|2[0-4][0-9]|25[0-5])$/
    }

    IntValidator {
        id: portValidator
        bottom: 0
        top: 99999
    }

    ColumnLayout{
        anchors.fill: parent
        anchors.margins: 10
        spacing: 5

        // App
        FieldGroup{
            id: appFieldGroup

            Layout.fillWidth: true
            Layout.preferredHeight: topPadding + bottomPadding + fieldHeight + 2*appFieldGroupModel.count
            name: qsTr("Roboblade")
            fieldHeight: root.fieldHeight
            validators: [ipValidator]
            objectModel: ObjectModel{
                id: appFieldGroupModel

                Field{
                    id: appIPAddress; fieldName: qsTr("Local Address:"); fieldText: qsTr("192.168.1.1"); validator: ipValidator
                    onFieldTextChanged: {
                        signals.set(1,{signal: root.appIPAddressChanged, arg: appIPAddress.fieldText})
                    }
                }
            }
        }

        GridLayout{
            rows: 2; columns: 2
            rowSpacing: 10

            // KRC | MAKE BETTER
            FieldGroupKRC{
                id: krcFieldGroup

                Layout.fillWidth: true; Layout.preferredWidth: 50
                Layout.preferredHeight: topPadding + bottomPadding + 4*fieldHeight + spacing + 4*2
                Layout.alignment: Qt.AlignTop
                name: qsTr("KRC")
                fieldHeight: root.fieldHeight
                networkSettingsWindow: root
            }

            // VFD
            FieldGroup{
                id: vfdFieldGroup

                Layout.fillWidth: true; Layout.preferredWidth: 50
                Layout.preferredHeight: topPadding + bottomPadding + vfdFieldGroupModel.count*fieldHeight + spacing + 2*vfdFieldGroupModel.count
                Layout.alignment: Qt.AlignTop
                name: qsTr("VFD")
                fieldHeight: root.fieldHeight
                validators: [portValidator, ipValidator, portValidator]
                objectModel: ObjectModel{
                    id: vfdFieldGroupModel

                    Field{
                        id: vfdLocalPort; fieldName: qsTr("Local Port:"); fieldText: qsTr("11111"); validator: portValidator
                        onFieldTextChanged: {
                            signals.set(4,{signal: root.vfdLocalPortChanged, arg: vfdLocalPort.fieldText})
                        }
                    }
                    Field{
                        id: vfdIPAddress; fieldName: qsTr("Peer Address:"); fieldText: qsTr("192.168.1.4"); validator: ipValidator
                        onFieldTextChanged: {
                            signals.set(5,{signal: root.vfdIPAddressChanged, arg: vfdIPAddress.fieldText})
                        }
                    }
                    Field{
                        id: vfdPeerPort;  fieldName: qsTr("Peer Port:"); fieldText: qsTr("22222"); validator: portValidator
                        onFieldTextChanged: {
                            signals.set(6,{signal: root.vfdPeerPortChanged, arg: vfdPeerPort.fieldText})
                        }
                    }
                }

            }

            // FTS | FTS peer port is binded to 49152
            FieldGroup{
                id: ftsFieldGroup

                Layout.fillWidth: true; Layout.preferredWidth: 50
                Layout.preferredHeight: topPadding + bottomPadding + 2*fieldHeight + spacing + 2*ftsFieldGroupModel.count
                Layout.alignment: Qt.AlignTop
                name: qsTr("FTS")
                fieldHeight: root.fieldHeight
                validators: [portValidator, ipValidator]
                objectModel: ObjectModel{
                    id: ftsFieldGroupModel

                    Field{
                        id: ftsLocalPort; fieldName: qsTr("Local Port:"); fieldText: qsTr("59152"); validator: portValidator
                        onFieldTextChanged: {
                            signals.set(7,{signal: root.ftsLocalPortChanged, arg: ftsLocalPort.fieldText})
                        }
                    }
                    Field{
                        id: ftsIPAddress; fieldName: qsTr("Peer Address:"); fieldText: qsTr("192.168.1.3"); validator: ipValidator
                        onFieldTextChanged: {
                            signals.set(8,{signal: root.ftsIPAddressChanged, arg: ftsIPAddress.fieldText})
                        }
                    }
                }
            }

            // Houdini
            FieldGroup{
                id: houFieldGroup

                Layout.fillWidth: true; Layout.preferredWidth: 50
                Layout.preferredHeight: topPadding + bottomPadding + 2*fieldHeight + spacing + 2*houFieldGroupModel.count
                Layout.alignment: Qt.AlignTop
                name: qsTr("Houdini")
                fieldHeight: root.fieldHeight
                validators: [portValidator, portValidator]
                objectModel: ObjectModel{
                    id: houFieldGroupModel

                    Field{
                        id: houLocalPort; fieldName: qsTr("Local Port:"); fieldText: qsTr("1111"); validator: portValidator
                        onFieldTextChanged: {
                            signals.set(9,{signal: root.houLocalPortChanged, arg: houLocalPort.fieldText})
                        }
                    }
                    Field{
                        id: houPeerPort; fieldName: qsTr("Peer Port:");  fieldText: qsTr("2222"); validator: portValidator
                        onFieldTextChanged: {
                            signals.set(10,{signal: root.houPeerPortChanged, arg: houPeerPort.fieldText})
                        }
                    }
                }

            }
        }
    }
}
