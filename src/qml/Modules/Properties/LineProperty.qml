import QtQuick 2.12
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.2

import qml.Modules.Styles 1.0
import qml.Modules.Components 1.0


Item {
    id: root

    property var wgt

    signal editingFinished()

    implicitHeight: root.childrenRect.height

//    onWgtChanged: {
//        txtField.text = Qt.binding(function(){ return root.wgt.text })
//        colorProperty.wgt = Qt.binding(function(){ return root.wgt })

//        txtField.editingFinished.connect(function(){ wgt.text = txtField.text })
//        fontFamilies.currentTextChanged.connect(function(){ wgt.font.family = fontFamilies.currentText })
//        fontWeight.currentValueChanged.connect(function(){ wgt.font.weight = fontWeight.currentValue })
//        fontPixelSize.currentValueChanged.connect(function(){ wgt.font.pixelSize = fontPixelSize.currentValue })
//    }

    ColumnLayout{
        id: rootCL

        RowLayout{
            id: lineStyleRL

            Layout.fillWidth: true; Layout.preferredHeight: 25
            spacing: 10

            QxComboBox{
                id: lineStyle

                Layout.preferredWidth: 95; Layout.preferredHeight: parent.height
                font: Styles.fonts.caption
                valueRole: "value"
                textRole: "text"
                model:[
                    { value: Qt.SolidLine,   text: qsTr("Solid") },
                    { value: Qt.DashLine,    text: qsTr("DashLine") },
                    { value: Qt.DotLine,     text: qsTr("DotLine") },
                    { value: Qt.DashDotLine, text: qsTr("DashDotLine") },
                ]

                Component.onCompleted: { currentIndex = indexOfValue(Qt.SolidLine) }
            }
            QxComboBox{
                id: lineWidth

                Layout.preferredWidth: 60; Layout.preferredHeight: parent.height
                font: Styles.fonts.caption
                model: [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ]

                Component.onCompleted: { currentIndex = indexOfValue(1) }
            }
        }
        // ColorProperty{
        //     id: lineColor
        //     wgt: root.wgt
        // }
    }
}
