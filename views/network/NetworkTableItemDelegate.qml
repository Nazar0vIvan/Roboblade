import QtQuick 2.12
import QtQuick.Controls 2.15

import AppStyle 1.0

ItemDelegate{
    id: control

    property real overlay
    property color color: AppStyle.foreground

    contentItem: Text{
        verticalAlignment: Text.AlignVCenter
        text: control.text
        font: control.font
        color: control.color
        opacity: AppStyle.emphasis.high
    }

    background: Rectangle{
        color: AppStyle.foreground
        opacity: control.overlay
    }
}
