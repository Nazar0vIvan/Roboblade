import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.15

import AppStyle 1.0

Item {
    id: root

    property font fieldFont: AppStyle.fonts.body
    property alias spacing: rootRL.spacing

    property string labelName
    property alias labelBgd: label.background
    property int labelWidth: 100
    property color labelColor: AppStyle.foreground
    property string labelOpacity: AppStyle.elevation.high

    property Item widget: w

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

        Item{
            id: w
        }

        Rectangle{ Layout.fillWidth: true } // filler
    }

}
