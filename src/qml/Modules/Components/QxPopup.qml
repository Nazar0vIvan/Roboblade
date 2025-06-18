import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.15

import qml.Modules.Styles 1.0

Popup{
    id: control

    property int componentHeight
    property int labelWidth
    property int fieldWidth
    property list<Item> components
    property int componentSpacing: 0

    x: -implicitWidth + parent.width; y: parent.height + 10

    // contentWidth and contentHeight don't consider padding!
    implicitWidth: contentWidth + 2*padding; implicitHeight: contentHeight + 2*padding

    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent
    padding: 10
    background: Rectangle{
        color: Styles.background.dp00
        radius: 8
        border{ width: 1; color: "gray" }
    }

    contentItem: ColumnLayout{

        spacing: control.spacing

        Component.onCompleted:{
            for (var i = 0; i < components.length; i++){
                components[i].parent = contentItem

                components[i].Layout.preferredHeight = control.componentHeight
                components[i].labelWidth = control.labelWidth
                components[i].spacing = control.componentSpacing
                components[i].font = control.font
                components[i].field.Layout.preferredHeight = control.componentHeight
                components[i].field.Layout.preferredWidth = control.fieldWidth
            }
        }
    }
}
