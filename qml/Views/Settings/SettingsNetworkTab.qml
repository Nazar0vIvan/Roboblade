import QtQuick 2.15
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.15
import QtQml.Models 2.15

import AppStyles 1.0
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

  signal requestSocketsInfo()
  signal requestParseConfigFile(string url)

  function slotUpdateUI(socketID, hostName, localAddress, localPort, peerAddress, peerPort, protocol, status, openMode){
    switch(socketID){
    case 0:{
      krcLocalAddress.field.text = localAddress
      krcLocalPort.field.text = localPort
      krcPeerAddress.field.text = peerAddress
      krcPeerPort.field.text = peerPort ? peerPort : "N/D"
      krcOnlySend.field.text = openMode === 1 ? "TRUE" : "FALSE"
      break
    }
    case 1:{
      ftsLocalAddress.field.text = localAddress
      ftsLocalPort.field.text = localPort
      ftsPeerAddress.field.text = peerAddress
      ftsPeerPort.field.text = peerPort
      break
    }
    case 2:{
      houLocalPort.field.text = localPort
      houPeerPort.field.text = peerPort
      break
    }
    case 3:
      vfdA65LocalAddress.field.text = localAddress
      vfdA65LocalPort.field.text = localPort
      vfdA65PeerAddress.field.text = peerAddress
      vfdA65PeerPort.field.text = peerPort
    }
  }

  signal ftsLocalPortChanged(int localPort)
  signal ftsPeerAddressChanged(string peerAddress)
  signal houLocalPortChanged(int localPort)
  signal houPeerPortChanged(int peerPort)
  signal vfdA65LocalPortChanged(int localPort)
  signal vfdA65PeerAddressChanged(string peerAddress)
  signal vfdA65PeerPortChanged(int peerPort)

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
          field: AppFileUpload {
            fieldWidth: _fieldWidth
            onAccepted: currentFile => {
                          uploadFile.field.text = currentFile.toString().slice(8)
                          requestParseConfigFile(currentFile)
                        }
          }
        },
        AppFormComponent{
          id: krcLocalAddress

          labelName: qsTr("Local Address")
          field: AppTextField{
            defaultTxt: qsTr("defined by Configuration File")
            readOnly: true
            enabled: false
          }
        },
        AppFormComponent{
          id: krcLocalPort

          labelName: qsTr("Local Port")
          field: AppTextField{
            defaultTxt: qsTr("defined by Configuration File")
            readOnly: true
            enabled: false
          }
        },
        AppFormComponent{
          id: krcPeerAddress

          labelName: qsTr("Peer Address")
          field: AppTextField{
            defaultTxt: qsTr("defined by Configuration File")
            readOnly: true
            enabled: false
          }
        },
        AppFormComponent{
          id: krcPeerPort

          labelName: qsTr("Peer Port")
          field: AppTextField{
            text: qsTr("N/D")
            readOnly: true
            enabled: false
          }
        },
        AppFormComponent{
          id: krcOnlySend

          labelName: qsTr("ONLYSEND")
          field: AppTextField{
            defaultTxt: qsTr("defined by Configuration File")
            readOnly: true
            enabled: false
          }
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
            borderWidth: 0
            readOnly: true
          }
        },
        /**/AppFormComponent{
          id: ftsLocalPort

          labelName: qsTr("Local Port");
          field: AppTextField{
            validator: portValidator
            onEditingFinished:{ signals.set(1, {signal: root.ftsLocalPortChanged, arg: text}) }
          }
        },
        /**/AppFormComponent{
          id: ftsPeerAddress

          labelName: qsTr("Peer Address")
          field: AppTextField{
            validator: ipValidator
            onEditingFinished:{ signals.set(2, {signal: root.ftsPeerAddressChanged, arg: text}) }
          }
        },
        AppFormComponent{
          id: ftsPeerPort

          labelName: qsTr("Peer Port")
          field: AppTextField{
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
        /**/AppFormComponent{
          id: houLocalPort

          labelName: qsTr("Local Port")
          field: AppTextField{
            validator: portValidator
            onEditingFinished:{ signals.set(3, {signal: root.houLocalPortChanged, arg: text}) }
          }
        },
        /**/AppFormComponent{
          id: houPeerPort

          labelName: qsTr("Peer Port")
          field: AppTextField{
            validator: portValidator
            onEditingFinished:{ signals.set(4, {signal: root.houPeerPortChanged, arg: text}) }
          }
        }
      ]
    }
    // <- hou

    // -> vfd
    SettingsSection{
      id: vfdA65Settings

      width: root.width
      titleName: qsTr("Variable Frequency Drive A65")
      componentHeight: _componentHeight; componentsSpacing: _componentsSpacing
      labelWidth: _labelWidth; fieldWidth: _fieldWidth; componentSpacing: _componentSpacing
      components:[
        AppFormComponent{
          id: vfdA65LocalAddress

          labelName: qsTr("Local Address");
          field: AppTextField{
            borderWidth: 0
            readOnly: true
          }
        },
        /**/AppFormComponent{
          id: vfdA65LocalPort

          labelName: qsTr("Local Port")
          field: AppTextField{
            validator: portValidator
            onEditingFinished:{ signals.set(5, {signal: root.vfdA65LocalPortChanged, arg: text}) }
          }
        },
        /**/AppFormComponent{
          id: vfdA65PeerAddress

          labelName: qsTr("Peer Address");
          field: AppTextField{
            validator: ipValidator
            onEditingFinished:{ signals.set(6, {signal: root.vfdA65PeerAddressChanged, arg: text}) }
          }
        },
        /**/AppFormComponent{
          id: vfdA65PeerPort

          labelName: qsTr("Peer Port")
          field: AppTextField{
            validator: portValidator
            onEditingFinished:{ signals.set(7, {signal: root.vfdA65PeerPortChanged, arg: text}) }
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
    icolor: Styles.background.dp01
    iopacity: 0.5
    iborderc: "gray"
    iborderw: 1
  }

  Component.onCompleted:{
    requestParseConfigFile.connect(socketRSI.slotParseConfigFile)
    requestSocketsInfo.connect(socketRDT.slotRequestSocketInfo)
    requestSocketsInfo.connect(socketHou.slotRequestSocketInfo)
    requestSocketsInfo.connect(socketVFDA65.slotRequestSocketInfo)

    socketRSI.sendSocketInfo.connect(slotUpdateUI)
    socketRDT.sendSocketInfo.connect(slotUpdateUI)
    socketHou.sendSocketInfo.connect(slotUpdateUI)
    socketVFDA65.sendSocketInfo.connect(slotUpdateUI)

    ftsLocalPortChanged.connect(socketRDT.slotLocalPortChanged)
    ftsPeerAddressChanged.connect(socketRDT.slotPeerAddressChanged)
    houLocalPortChanged.connect(socketHou.slotLocalPortChanged)
    houPeerPortChanged.connect(socketHou.slotPeerPortChanged)
    vfdA65LocalPortChanged.connect(socketVFDA65.slotLocalPortChanged)
    vfdA65PeerAddressChanged.connect(socketVFDA65.slotPeerAddressChanged)
    vfdA65PeerPortChanged.connect(socketVFDA65.slotPeerPortChanged)

    // initialize ui
    requestSocketsInfo()
  }
}

