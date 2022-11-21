import QtQuick 2.12
import QtQuick.Controls 2.15
import QtQuick.Controls.Basic
import QtQuick.Layouts 1.2

import AppStyle 1.0

ComboBox{
    id: control

    editable: true
    font: AppStyle.fonts.body

    implicitWidth: 165; implicitHeight: 25

    contentItem: TextField {
        leftPadding: 0; leftInset: -5;
        verticalAlignment: TextInput.AlignVCenter

        text: control.currentText
        color: AppStyle.foreground
        font: control.font
        opacity: AppStyle.elevation.high

        selectByMouse: true
        selectionColor: AppStyle.highlight

        activeFocusOnPress: true
        background: Rectangle{
            color: "transparent"
            border{
                width: control.contentItem.activeFocus ? 2 : control.hovered ? 1 : 0;
                color: control.contentItem.activeFocus ? AppStyle.primary.base : "gray"
            }
        }
    }

    background: Rectangle{ color: AppStyle.background }

    indicator: Control{
        x: control.width - width
        width: control.height; height: control.height
        padding: 8
        background: Rectangle{
            color: AppStyle.background
            border{
                width: control.contentItem.activeFocus || control.hovered ? 1 : 0
                color: "gray"
            }
        }
        contentItem: Image{
            source: "file:///" + applicationDirPath + "/icons/arrow_down.svg"
            fillMode: Image.PreserveAspectFit
            mipmap: true
            visible: control.hovered || control.contentItem.activeFocus
        }
    }

    popup: Popup{
        width: control.width; implicitHeight: contentItem.implicitHeight
        padding: 10

        contentItem: ListView {
            clip: true
            implicitHeight: contentHeight
            model: control.popup.visible ? control.delegateModel : null
            currentIndex: control.highlightedIndex

            ScrollIndicator.vertical: ScrollIndicator { }
        }

        background: Rectangle {
            color: AppStyle.background
            border{ width: 1; color: "gray" }
        }
    }

    delegate: ItemDelegate{

        required property int index
        required property var modelData

        padding: 5
        width: control.width
        contentItem: Text {
            text: modelData.text === undefined ? modelData : modelData.text
            color: AppStyle.foreground
            font: AppStyle.fonts.caption
            opacity: AppStyle.elevation.high
            verticalAlignment: Text.AlignVCenter
        }
        highlighted: control.highlightedIndex === index

        background: Rectangle{ color: AppStyle.background }
    }
}
