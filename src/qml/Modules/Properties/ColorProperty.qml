import QtQuick 2.12
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.2

import qml.Modules.Styles 1.0
import qml.Modules.Components 1.0

Item{
    id: root

    property int fieldWidth: 100
    property alias font: txtColor.font
    property alias spacing: rootRL.spacing
    property alias color: txtColor.text

    function setColor(color){
        txtColor.text = color;
        colorPicker.contentItem.color = "#" + txtColor.text
    }
    function getColor(){ return "#" + txtColor.text }

    signal editingFinished()

    implicitHeight: 25

    RowLayout{
        id: rootRL

        height: parent.height
        spacing: 4

        Control{
            id: colorPicker

            Layout.preferredWidth: parent.height; Layout.preferredHeight: parent.height
            Layout.alignment: Qt.AlignVCenter
            padding: 5
            contentItem: Rectangle{
                width: colorPicker.width; height: colorPicker.height
                radius: width/2
                border{ width: 1; color: "gray" }
            }
            background: Rectangle{
                color: "transparent"
                antialiasing: true
                radius: 4
                border{ width: colorPicker.hovered ? 1 : 0; color: "gray" }
            }
        }

        QxTextField{
            id: txtColor

            Layout.preferredWidth: root.fieldWidth; Layout.preferredHeight: parent.height
            Layout.alignment: Qt.AlignVCenter

            color: "transparent"
            font{ family: "Roboto"; pixelSize: 12; capitalization: Font.AllUppercase }
            inputMask: "HHHHHH"
            text: "FFFFFF"

            onEditingFinished:{ root.editingFinished() }
        }

        /*
        TextField{
            id: txtOpacity

            Layout.preferredWidth: 50; Layout.preferredHeight: 25
            Layout.alignment: Qt.AlignVCenter
            verticalAlignment: Text.AlignVCenter
            leftPadding: 5

            background: Rectangle{
                color: "transparent"
                border{
                    width: txtOpacity.activeFocus ? 2 : txtOpacity.hovered ? 1 : 0;
                    color: txtOpacity.activeFocus ? Styles.primary.base : "gray"
                }
            }

            activeFocusOnPress: true
            font: Styles.fonts.caption
            color: Styles.foreground
            opacity: Styles.emphasis.high

            selectionColor: Styles.primary.highlight
            selectByMouse: true
        }
        */
    }
}
