import QtQuick 2.12
import QtQuick.Controls 2.15

import qml.Modules.Styles 1.0

TabButton{
    id: root

    leftPadding: 0
    contentItem: Text{
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignLeft
        text: root.text
        color: root.checked ? Styles.secondary.base : Styles.foreground.high
        font: root.checked ? Styles.fonts.subtitle : Styles.fonts.body
    }
    background: Rectangle{ color: "transparent" }
}
