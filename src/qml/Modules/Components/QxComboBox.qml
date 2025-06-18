import QtQuick 2.12
import QtQuick.Controls 2.15
import QtQuick.Controls.Basic
import QtQuick.Layouts 1.2

import qml.Modules.Styles 1.0

ComboBox{
    id: control

    property int offset: 8

    signal editingFinished()

    implicitWidth: 165; implicitHeight: 25
    editable: true
    font: Styles.fonts.body

    contentItem: TextField {
        leftPadding: 5
        verticalAlignment: TextInput.AlignVCenter

        text: control.currentText
        color: Styles.foreground.high
        font: control.font

        selectByMouse: true
        selectionColor: Styles.primary.highlight

        activeFocusOnPress: true
        background: Rectangle{ color: "transparent" }
    }

    background: Rectangle{
        color: Styles.background.dp00
        border{
            width: control.contentItem.activeFocus || control.hovered || control.popup.visible ? 1 : 0
            color: "gray"
        }
    }

    indicator: Control{
        x: control.width - width
        width: control.height; height: control.height
        padding: 8
        background: Rectangle{ color: "transparent" }
        contentItem: Image{
            //source: "file:///" + applicationDirPath + "/icons/arrow_down.svg"
            fillMode: Image.PreserveAspectFit
            mipmap: true
            visible: control.hovered || control.contentItem.activeFocus || control.popup.visible
        }
    }

    popup: Popup{
        y: control.height + 5
        width: control.width; implicitHeight: contentItem.implicitHeight + 5
        padding: 2

        contentItem: ListView {
            clip: true
            implicitHeight: contentHeight
            model: control.popup.visible ? control.delegateModel : null
            currentIndex: control.highlightedIndex
            spacing: 5
            ScrollIndicator.vertical: ScrollIndicator { }
        }

        background: Rectangle {
            color: Styles.background.dp00
            border{ width: 1; color: "gray" }
        }
    }

    delegate: ItemDelegate{

        required property int index
        required property var modelData

        padding: offset
        width: control.popup.width
        contentItem: Text {
            text: modelData.text === undefined ? modelData : modelData.text
            color: Styles.foreground.high
            font: control.font
            verticalAlignment: Text.AlignVCenter
        }
        background: Rectangle { color: hovered ? Styles.primary.highlight : Styles.background }
    }

    onCurrentTextChanged: control.editingFinished()
    onCurrentValueChanged: control.editingFinished()
    onAccepted: control.editingFinished()
}
