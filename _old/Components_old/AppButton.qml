import QtQuick 2.12
import QtQuick.Controls 2.12

// needs to add due to Qt6.3 and Windows bug: control.pressed doesn't work on Windows
import QtQuick.Controls.Basic

import AppStyle 1.0

Button{
    id: control

    property int textFormat

    rightPadding: control.pressed ? 6 : 5
    topPadding: control.pressed ? 6 : 5
    text: ""
    flat: true
    font: AppStyle.fonts.body

    contentItem: Text{
        elide: Text.ElideMiddle
        verticalAlignment: Text.AlignVCenter; horizontalAlignment: Text.AlignHCenter
        text: control.text
        textFormat: control.textFormat
        font: control.font
        color: AppStyle.foreground
        opacity: control.enabled ? AppStyle.elevation.high : AppStyle.elevation.disabled
    }
    background: Rectangle{
        color: control.pressed ? AppStyle.surface : control.hovered ? AppStyle.background : AppStyle.surface
        border{ width: 1; color: AppStyle.surface }
        radius: 4
    }


}
