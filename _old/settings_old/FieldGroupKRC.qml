import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.2
import QtQml.Models 2.15
import QtQuick.Dialogs 1.3

import AppStyle 1.0

import "../../.."

Item {
    id: root

    required property string name
    required property int fieldHeight
    required property var networkSettingsWindow

    property alias topPadding: groupBox.topPadding
    property alias bottomPadding: groupBox.bottomPadding
    property alias spacing: fieldGroupLayout.spacing

    FileDialog {
        id: fileDialog
        folder: "."
        title: qsTr("Choose Config File")
        selectMultiple: false
        nameFilters: [ "XML files (*.xml)", "All files (*)" ]
        onAccepted: {
            socketRSI.parseConfigFile(fileDialog.fileUrl) // socketRSI - C++ object
        }
    }

    MessageDialog {
        id: msgDialog

        title: qsTr("Error")
        icon: StandardIcon.Critical
        standardButtons: StandardButton.Ok
        modality: Qt.ApplicationModal
    }

    Connections{
        target: socketRSI
        function onSocketDataChanged(port, ipAddress, onlySend, filePath){
            krcLocalPort.fieldText = port
            krcIPAddress.fieldText = ipAddress
            krcOnlySend.fieldText = onlySend
            configFilePath.text = filePath
        }
        function onConfigFileOpenError(error){
            msgDialog.text = "File open error!"
            msgDialog.informativeText = error
            msgDialog.visible = true
        }
        function onConfigFileFormatError(errorMsg, errorLine, errorColumn){
            msgDialog.text = "Invalid file format!"
            msgDialog.informativeText = "Syntax Error: " + errorMsg + " " + errorLine + ":" + errorColumn
            msgDialog.visible = true
        }
        function onPortOrIPAddressFormatError(port, ipAddress){
            msgDialog.text = "Invalid Port or IP Address format!"
            msgDialog.informativeText = "Port: " + port + "\nIP Address: " + ipAddress
            msgDialog.visible = true
        }
    }

    GroupBox{
        id: groupBox

        anchors.fill: parent
        label: Label{
            color: "white";
            text: qsTr("KRC")
            font: AppStyle.settingsWindow.network.font
        }
        ColumnLayout{
            id: fieldGroupLayout

            anchors.fill: parent
            RowLayout{
                Layout.fillWidth: true; Layout.fillHeight: true
                Label{
                    Layout.preferredWidth: 65; Layout.preferredHeight: root.fieldHeight
                    text: "Config File:"
                    verticalAlignment: Text.AlignVCenter
                    color: AppStyle.settingsWindow.network.color
                    font: AppStyle.settingsWindow.network.font
                }
                TextField{
                    id: configFilePath
                    Layout.fillWidth: true; Layout.preferredHeight: root.fieldHeight
                    Layout.alignment: Qt.AlignVCenter
                    background: Rectangle{
                            color: "#10a0a0a0" // AppStyle.settingsWindow.network.background
                            border{color: "gray"; width: 1}
                    }
                    verticalAlignment: TextInput.AlignVCenter
                    leftPadding: 5
                    font: AppStyle.settingsWindow.network.font
                    color: AppStyle.settingsWindow.network.color
                    selectionColor: AppStyle.settingsWindow.network.selected
                    activeFocusOnPress: true
                    selectByMouse: true
                    readOnly: true
                }
                AppButton{
                    id: button

                    Layout.preferredWidth: 22; Layout.preferredHeight: 22
                    topPadding: 2
                    textFormat: Text.RichText
                    font{pixelSize: 14}
                    text: "&#xB7;" + "&#xB7;" + "&#xB7;"
                    onClicked: {
                        fileDialog.open()
                    }
                }
            }
            Field{
                id: krcLocalPort
                Layout.fillWidth: true; Layout.preferredHeight: root.fieldHeight
                fieldName: qsTr("Local Port:")
                fieldDefaultText: "defined by Configure File..."
                background: "#10a0a0a0"
                readOnly: true
                onFieldTextChanged: {
                    networkSettingsWindow.signals.set(2,{signal: networkSettingsWindow.krcLocalPortChanged, arg: krcLocalPort.fieldText})
                }
            }
            Field{
                id: krcIPAddress
                Layout.fillWidth: true; Layout.preferredHeight: root.fieldHeight
                fieldName: qsTr("Local Address:")
                fieldDefaultText: "defined by Configure File..."
                background: "#10a0a0a0"
                readOnly: true
                onFieldTextChanged: {
                    networkSettingsWindow.signals.set(3,{signal: networkSettingsWindow.krcIPAddressChanged, arg: krcIPAddress.fieldText})
                }
            }
            Field{
                id: krcOnlySend
                Layout.fillWidth: true; Layout.preferredHeight: root.fieldHeight
                fieldName: qsTr("ONLYSEND:")
                fieldDefaultText: qsTr("defined by Configure File...")
                background: "#10a0a0a0"
                readOnly: true
//                onFieldTextChanged: {
//                    networkSettingsWindow.signals.set(3,{signal: networkSettingsWindow.krcIPAddressChanged, arg: krcIPAddress.fieldText})
//                }
            }
         }
    }
}
