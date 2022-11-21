import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.15

import AppStyle 1.0

Rectangle{
    id: root

    property color backgroundColor: AppStyle.surface
    property int borderWidth: 0
    property int hoverBorderWidth: 0
    property int borderRadius: 4
    property color borderColor: "gray"

    property alias defaultTxt: defaultTxt.text
    property color defaultTxtColor: AppStyle.foreground
    property real defaultTxtOpacity: AppStyle.emphasis.disabled

    property alias validator: txtField.validator
    property alias readOnly: txtField.readOnly
    property alias text: txtField.text
    property alias inputMask: txtField.inputMask
    property alias font: txtField.font

    signal editingFinished()

    color: txtField.readOnly ? "transparent" : backgroundColor
    radius: borderRadius
    border{
        width: root.readOnly ? 0 : txtField.activeFocus ? 2 : root.hovered ? hoverBorderWidth : borderWidth
        color: txtField.activeFocus ? AppStyle.primary.base : borderColor
    }

    TextField{
        id: txtField

        anchors.fill: parent

        verticalAlignment: Text.AlignVCenter
        leftPadding: 5
        font: AppStyle.fonts.body
        color: AppStyle.foreground
        opacity: root.readOnly ? AppStyle.emphasis.disabled : AppStyle.emphasis.high
        selectionColor: AppStyle.primary.highlight
        selectByMouse : true

        background: Rectangle{ color: "transparent" }

        onEditingFinished:{ root.editingFinished() }
        onAccepted: { editingFinished(); focus = false }
        onFocusChanged: if(focus) selectAll()
    }

    Text{
        id: defaultTxt

        anchors.fill: parent
        verticalAlignment: Text.AlignVCenter
        leftPadding: 5
        color: defaultTxtColor
        opacity: AppStyle.emphasis.disabled
        visible: !(txtField.activeFocus || txtField.text)
        font.italic: true
    }
}



