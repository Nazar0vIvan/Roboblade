import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.15

import AppStyle 1.0

TabButton{
    id: root

    contentItem: Text{
        horizontalAlignment: Text.AlignLeft; verticalAlignment: Text.AlignVCenter
        text: root.text
        color: root.checked ? AppStyle.secondary.base : AppStyle.foreground
        opacity: root.checked ? 1.0 : AppStyle.elevation.disabled
        font: root.checked ? AppStyle.fonts.subtitle : AppStyle.fonts.body
    }
    background: Rectangle{
        color: AppStyle.background
        border{ color: "blue" }
    }
}


/*
TabButton {
    id: root

    text: ""
    contentItem: Text{
        horizontalAlignment: Text.AlignLeft; verticalAlignment: Text.AlignVCenter
        text: root.text
        color: root.checked ? AppStyle.primary.base : AppStyle.foreground
        opacity: root.checked ? 1.0 : AppStyle.elevation.high
        font: AppStyle.fonts.body
    }
    background: Rectangle{
        color: root.checked ? AppStyle.primary.transparent : root.hovered ? AppStyle.foreground : "transparent"
        opacity: root.hovered & !root.checked ? AppStyle.elevation.disabled : 1.0
    }
}
*/
