import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.2

import AppStyle 1.0

Item{
    id: root

    signal currentIndexChanged(int index)

    required property var model

    property int elementHeight: 50
    property int elementIconSize: 25

    property color elementSelectionIconColor: AppStyle.primary.base
    property color elementDefaultIconColor: AppStyle.foreground

    ListView{
        id: listView

        anchors.fill: parent
        spacing: 0
        clip: true
        interactive: false
        model: root.model

        delegate: NavigationMenuDelegate {
            width: parent.width; height: root.elementHeight
            iconSize: root.elementIconSize
            selectionIconColor: root.elementSelectionIconColor
            defaultIconColor: root.elementDefaultIconColor
        }
        highlightFollowsCurrentItem: false

        section.property: "type"
        section.criteria: ViewSection.FullString
        section.delegate: Rectangle {
            width: parent.width; height: 40
            color: "transparent"
        }

        onCurrentIndexChanged:{ root.currentIndexChanged(currentIndex) }
    }
}
