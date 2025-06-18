import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.15

import qml.Modules.Styles 1.0

Rectangle {
    id: root

    property color backgroundColor: Styles.background.dp01
    property int borderWidth: 1
    property int hoverBorderWidth: 0
    property int borderRadius: 4
    property color borderColor: "gray"

    property alias defaultTxt: defaultTxt.text
    property color defaultTxtColor: Styles.foreground.high

    property alias validator: txtField.validator
    property alias readOnly: txtField.readOnly
    property alias text: txtField.text
    property alias inputMask: txtField.inputMask
    property alias font: txtField.font

    signal editingFinished()

    color: txtField.readOnly ? "transparent" : backgroundColor
    radius: borderRadius
    border {
        width: root.readOnly ? 0 : txtField.activeFocus ? 2 : root.hovered ? hoverBorderWidth : borderWidth
        color: txtField.activeFocus ? Styles.primary.base : borderColor
    }

    TextField {
        id: txtField

        anchors.fill: parent

        verticalAlignment: Text.AlignVCenter
        leftPadding: 5
        font: Styles.fonts.body
        color: root.readOnly ? Styles.foreground.disabled : Styles.foreground.high
        selectionColor: Styles.primary.highlight
        selectByMouse : true

        background: Rectangle{ color: "transparent" }

        onEditingFinished:{ root.editingFinished() }
        onAccepted: { editingFinished(); focus = false }
        onFocusChanged: if(focus) selectAll()
    }

    Text {
        id: defaultTxt

        anchors.fill: parent
        verticalAlignment: Text.AlignVCenter
        leftPadding: 5
        color: defaultTxtColor
        visible: !(txtField.activeFocus || txtField.text)
        font.italic: true
    }
}



