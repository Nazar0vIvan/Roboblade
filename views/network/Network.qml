import QtQuick 2.12
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

import AppStyle 1.0
import Components 1.0

Rectangle{
    id: root

    color: AppStyle.background

    ColumnLayout{
        id: rootCL

        anchors.fill: parent
        anchors.margins: 30
        spacing: 20

        Text{
            text: qsTr("Network")
            font: AppStyle.fonts.headline1
            color: AppStyle.foreground
            opacity: AppStyle.emphasis.high
        }

        AppComboBox{
            id: socketsComboBox

            Layout.preferredWidth: 250; Layout.preferredHeight: 30

            valueRole: "value"
            textRole: "text"
            model:[
                { value: 0, text: qsTr("KUKA Robot Controller") },
                { value: 1, text: qsTr("Force/Torque Sensor") },
                { value: 2, text: qsTr("Houdini") },
                { value: 3, text: qsTr("Variable Frequency Drive") },
            ]
        }

        StackLayout{
            id: networkSL

            currentIndex: socketsComboBox.currentIndex

            NetworkSocketTab{ id: krcNetwork }

            NetworkSocketTab{ id: ftsNetwork }

            NetworkSocketTab{ id: houNetwork }

            NetworkSocketTab{ id: vfdNetwork }
        }

    }

}

