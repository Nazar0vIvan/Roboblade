import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.2
import QtQml.Models 2.15

import AppStyle 1.0

Item{
    id: root

    required property string name
    required property int fieldHeight
    required property ObjectModel objectModel
//    property ListModel listModel
    property variant validators            // array of validators for text fields

//    required property variant fieldNames // array of fields names
//    property variant defaultTexts        // array of default textes for text fields

    property alias topPadding: groupBox.topPadding
    property alias bottomPadding: groupBox.bottomPadding
    property alias spacing: fieldGroupLayout.spacing

    signal groupInfoChanged(string groupName, string fieldName, string fieldText)

    GroupBox{
        id: groupBox

        anchors.fill: parent
        label: Label{
            text: name
            color: AppStyle.settingsWindow.network.color
            font: AppStyle.settingsWindow.network.font
        }
        ColumnLayout{
            id: fieldGroupLayout
            anchors.fill: parent
            spacing: 5

            Repeater{
                model: root.objectModel
                Component.onCompleted: {
                    for(var i = 0; i < root.objectModel.count; i++){
                        root.objectModel.get(i).Layout.fillWidth = true
                        root.objectModel.get(i).Layout.preferredHeight = root.fieldHeight
                    }
                }
            }
        }
    }
}

/*
    function createFields(){
        for(var i = 0; i < fieldNames.length; i++){
            var component = Qt.createComponent("Field.qml")
            var field = component.createObject(fieldGroupLayout, {"groupName: root.groupName
                                                                  "name": root.fieldNames[i],
                                                                  "text": root.defaultTexts[i],
                                                                  "validator": root.validators[i],
            });
            field.Layout.preferredHeight = root.fieldHeight
            field.Layout.fillWidth = true

        }
    }
*/
