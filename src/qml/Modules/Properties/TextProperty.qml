import QtQuick 2.12
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.2

import qml.Modules.Styles 1.0
import qml.Modules.Components 1.0

Item {
    id: root

    property alias readonly: txtField.readOnly

    function setText(text){ txtField.text = text }
    function setFamily(family){ fontFamilies.currentIndex = fontFamilies.indexOfValue(family) }
    function setWeight(weight){ fontWeights.currentIndex = fontWeights.indexOfValue(weight) }
    function setPixelSize(pixelSize){ fontPixelSizes.currentIndex = fontPixelSizes.indexOfValue(pixelSize) }

    function getText(){ return txtField.text }
    function getFamily(){ return fontFamilies.currentText }
    function getWeight(){ return fontWeights.currentValue }
    function getPixelSize(){ return fontPixelSizes.currentText }

    signal textEditingFinished()
    signal familyEditingFinished()
    signal weightEditingFinished()
    signal pixelSizeEditingFinished()

    implicitWidth: parent.width; implicitHeight: root.childrenRect.height

    ColumnLayout{
        id: rootCL

        width: parent.width
        spacing: 5

        QxTextField{
            id: txtField

            Layout.fillWidth: true; Layout.preferredHeight: 25
            color: "transparent"
            font: Styles.fonts.caption
            visible: !readOnly

            onEditingFinished: root.textEditingFinished()
        }

        QxComboBox{
            id: fontFamilies

            Layout.fillWidth: true; Layout.preferredHeight: 25
            font: Styles.fonts.caption
            model: Qt.fontFamilies()

            onEditingFinished: root.familyEditingFinished()
            Component.onCompleted: { currentIndex = indexOfValue("Roboto") }
        }
        RowLayout{
            id: fontRL

            Layout.fillWidth: true; Layout.preferredHeight: 25
            spacing: 10

            QxComboBox{
                id: fontWeights

                Layout.preferredWidth: 95; Layout.preferredHeight: parent.height
                font: Styles.fonts.caption
                valueRole: "value"
                textRole: "text"
                model:[
                    { value: Font.Thin,       text: qsTr("Thin")       },
                    { value: Font.ExtraLight, text: qsTr("ExtraLight") },
                    { value: Font.Light,      text: qsTr("Light")      },
                    { value: Font.Normal,     text: qsTr("Normal")     },
                    { value: Font.Medium,     text: qsTr("Medium")     },
                    { value: Font.DemiBold,   text: qsTr("DemiBold")   },
                    { value: Font.Bold,       text: qsTr("Bold")       },
                    { value: Font.ExtraBold,  text: qsTr("ExtraBold")  },
                    { value: Font.Black,      text: qsTr("Black")       }
                ]

                onEditingFinished: root.weightEditingFinished()
                Component.onCompleted: { currentIndex = indexOfValue(Font.Normal) }
            }
            QxComboBox{
                id: fontPixelSizes

                Layout.preferredWidth: 60; Layout.preferredHeight: parent.height
                font: Styles.fonts.caption
                model: [10, 11, 12, 13, 14, 15, 16, 20, 22, 24, 28, 32, 36, 40, 48, 64, 96, 128]

                onEditingFinished: { root.pixelSizeEditingFinished() }
                Component.onCompleted: { currentIndex = indexOfValue(14) }
            }
        }
    }
}
