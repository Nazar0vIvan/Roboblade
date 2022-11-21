import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.15

import AppStyle 1.0

Item{
    id: root

    property font fieldFont: AppStyle.fonts.body
    property alias spacing: rootRL.spacing

    property string labelName
    property alias labelBgd: label.background
    property int labelWidth: 100
    property color labelColor: AppStyle.foreground
    property string labelOpacity: AppStyle.elevation.high

    property int txtFieldWidth: 100
    property color txtFieldBgdColor: "transparent"
    property int txtFieldBorderWidth: 1
    property int txtFieldBorderRadius: 4
    property color txtFieldBorderColor: "gray"
    property alias text: txtField.text
    property color txtFieldColor: AppStyle.foreground
    property real txtFieldOpacity: AppStyle.elevation.high
    property color txtSelectionColor: AppStyle.highlight
    property alias validator: txtField.validator
    property alias readOnly: txtField.readOnly

    property alias defaultTxt: defaultTxt.text
    property color defaultTxtColor: AppStyle.foreground
    property real defaultTxtOpacity: AppStyle.elevation.disabled

    signal editingFinished()

    implicitWidth: childrenRect.width

    RowLayout{
        id: rootRL

        height: root.height

        Label{
            id: label

            Layout.preferredWidth: Math.max(root.labelWidth,label.implicitWidth)
            Layout.preferredHeight: root.height
            Layout.alignment: Qt.AlignLeft
            verticalAlignment: Text.AlignVCenter
            text: labelName
            font: fieldFont
            color: labelColor
            opacity: labelOpacity
        }
        TextField{
            id: txtField

            Layout.preferredWidth: txtFieldWidth
            Layout.preferredHeight: root.height
            verticalAlignment: Text.AlignVCenter
            leftPadding: 5
            font: fieldFont
            color: txtFieldColor
            opacity: txtFieldOpacity
            selectionColor: txtSelectionColor
            selectByMouse: true

            background: Rectangle{
                color: txtFieldBgdColor
                radius: txtFieldBorderRadius
                border{
                    width: txtField.readOnly ? 0 : txtField.activeFocus ? 2 : txtField.hovered ? 1 : txtFieldBorderWidth
                    color: txtField.activeFocus ? AppStyle.primary.base : txtFieldBorderColor
                }
            }
            onEditingFinished: root.editingFinished()

            Text{
                id: defaultTxt

                anchors.fill: parent
                verticalAlignment: Text.AlignVCenter
                leftPadding: 5
                color: defaultTxtColor
                opacity: defaultTxtOpacity
                visible: !txtField.text
                font.italic: true
            }
        }

        Rectangle{ Layout.fillWidth: true } // filler
    }
}

