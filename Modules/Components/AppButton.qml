import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.2

// needs to add due to Qt6.3 and Windows bug: control.pressed doesn't work on Windows
import QtQuick.Controls.Basic

import AppStyle 1.0

Button{
    id: control

    property color backgroundColor: AppStyle.background.dp00
    property color borderColor: AppStyle.background.dp01
    property color color: AppStyle.foreground.high
    property int type: AppStyle.ButtonType.Contained
    readonly property var overlay: AppStyle.buttonType2Overlay.get(type)
    property int textFormat: Text.AutoText

    property int iconSize: 0
    property string iconPath: ""
    property color iconColor: "black"

    font: AppStyle.fonts.body

    contentItem: RowLayout{

        property var icon: children[0]
        property var text: children[1]

        spacing: 0

        AppIcon{
            Layout.preferredWidth: control.iconSize; Layout.preferredHeight: control.iconSize
            source: control.iconPath
            color: control.iconColor
        }

        Text{
            Layout.alignment: iconPath ? Qt.AlignLeft : Qt.AlignCenter
            text: control.text
            textFormat: control.textFormat
            font: control.font
            color: control.color
            opacity: control.enabled ? AppStyle.foreground.high : AppStyle.foreground.disabled
        }
    }

    background: Rectangle{
        color: backgroundColor
        border{ width: 1; color: borderColor }
        radius: 4

        Rectangle{
            anchors.fill: parent
            color: AppStyle.foreground.high
            radius: parent.radius
            opacity: control.pressed ? overlay.pressed : control.hovered ? overlay.hovered : 0
        }
    }
}
