import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.2

// needs to add due to Qt6.3 and Windows bug: control.pressed doesn't work on Windows
import QtQuick.Controls.Basic

import Modules.Styles 1.0 as Styles

Button {
    id: control

    property color backgroundColor: Styles.background.dp00
    property color borderColor: Styles.background.dp01
    property color color: Styles.foreground.high
    property int type: Styles.ButtonType.Contained
    readonly property var overlay: Styles.buttonType2Overlay.get(type)
    property int textFormat: Text.AutoText

    property int iconSize: 0
    property string iconPath: ""
    property color iconColor: "black"

    font: Styles.fonts.body

    contentItem: RowLayout{

        property var icon: children[0]
        property var text: children[1]

        spacing: 0

        AppIcon{
            Layout.preferredWidth: control.iconSize; Layout.preferredHeight: control.iconSize
            source: control.iconPath
            color: control.iconColor
        }

        Text {
            Layout.alignment: iconPath ? Qt.AlignLeft : Qt.AlignCenter
            text: control.text
            textFormat: control.textFormat
            font: control.font
            color: control.color
            // opacity: control.enabled ? Styles.foreground.high : Styles.foreground.disabled
        }
    }

    background: Rectangle{
        color: backgroundColor
        border{ width: 1; color: borderColor }
        radius: 4

        Rectangle{
            anchors.fill: parent
            color: Styles.foreground.high
            radius: parent.radius
            opacity: control.pressed ? overlay.pressed : control.hovered ? overlay.hovered : 0
        }
    }
}
