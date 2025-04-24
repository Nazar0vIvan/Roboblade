import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.2

import AppStyles 1.0

Item{
    id: root

    signal currentIndexChanged(int index)

    required property var model

    property int elemHeight: 50
    property int elemIconSize: 25

    property color elemSelectionIconColor: Styles.primary.base
    property color elemDefaultIconColor: "#a6a6a6"

    ListView{
        id: lv

        anchors.fill: parent
        spacing: 0
        clip: true
        interactive: false
        model: root.model

        delegate: NavigationMenuDelegate {
            width: parent.width; height: root.elemHeight
            iconSize: root.elemIconSize
            selectionIconColor: root.elemSelectionIconColor
            defaultIconColor: root.elemDefaultIconColor
        }
        highlightFollowsCurrentItem: false

        section.property: "type"
        section.criteria: ViewSection.FullString
        section.delegate: Rectangle {
            width: parent.width; height: lv.height - elemHeight * lv.count
            color: "transparent"
        }

        onCurrentIndexChanged:{ root.currentIndexChanged(currentIndex) }
    }
}
