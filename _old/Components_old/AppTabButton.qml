import QtQuick 2.12
import QtQuick.Controls 2.15

import AppStyle 1.0

TabButton{
    id: root

    leftPadding: 0

    contentItem: Text{
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignLeft
        text: root.text
        color: root.checked ? AppStyle.secondary.base : AppStyle.foreground
        opacity: root.checked ? 1.0 : AppStyle.elevation.disabled
        font: root.checked ? AppStyle.fonts.subtitle : AppStyle.fonts.body
    }
    background: Rectangle{
        color: AppStyle.background
        border{ color: "transparent" }
    }
    Rectangle{
        anchors.bottom: parent.bottom
        width: parent.width; height: 1
        color: AppStyle.foreground
        opacity: AppStyle.elevation.disabled
    }
}
