import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.15

import AppStyle 1.0

Item{
    id: root

    property font font: AppStyle.fonts.body
    property alias spacing: rootRL.spacing

    property string labelName
    property alias labelBackground: label.background
    property int labelWidth: 100
    property color labelColor: AppStyle.foreground
    property string labelOpacity: AppStyle.emphasis.high

    required property Item field

    implicitWidth: childrenRect.width

    signal editingFinished()

    RowLayout{
        id: rootRL

        height: parent.height

        Label{
            id: label

            Layout.preferredWidth: Math.max(root.labelWidth,label.implicitWidth)
            Layout.preferredHeight: parent.height
            Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
            verticalAlignment: Text.AlignVCenter
            text: root.labelName
            font: root.font
            color: root.labelColor
            opacity: root.labelOpacity
        }
        Component.onCompleted:{ field.parent = rootRL }
    }

    onFieldChanged:{ field.editingFinished.connect(root.editingFinished) }
}
