import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.2

import AppStyle 1.0

Item{
    id: root

    signal currentIndexChanged(int index)

    required property font font
    required property var model


    property int elementLeftMargin: 20
    property int elementRightMargin: 20
    property int elementLeftPadding: 10
    property int elementHeight: 45
    property int elementIconSize: 25
    property int elementSpacing: 20

    property color elementSelectionIconColor: AppStyle.primary.base
    property color elementSelectionTextColor: AppStyle.primary.base
    property color elementDefaultIconColor: "gray"
    property color elementDefaultTextColor: AppStyle.foreground

    property color highlightColor: AppStyle.primary.base
    property real highlightColorOpacity: 0.2
    property real highlightRadius: 4

    ListView{
        id: listView

        /*
        function maxElementWidth(){
            const elements = listView.contentItem.children
            if(elements.length) var max = elements[0].width; else return 0
            for(var i = 1; i < elements.length; i++){
                if(max < elements[i].width) max = elements[i].width
            }
            return max
        }
        */

        anchors{
            fill: parent
            leftMargin: root.elementLeftMargin
            rightMargin: root.elementRightMargin
        }
        spacing: 0
        clip: true
        interactive: false
        model: root.model
        delegate: NavigationMenuDelegate {
            width: parent.width; height: root.elementHeight
            leftMargin: root.elementLeftPadding
            spacing: elementIconSize ? root.elementSpacing : 0
            iconSize: root.elementIconSize
            font: root.font
            selectionIconColor: elementSelectionIconColor
            selectionTextColor: elementSelectionTextColor
            defaultIconColor: elementDefaultIconColor
            defaultTextColor: elementDefaultTextColor
        }
        highlight: Rectangle {
            y: listView.currentItem.y
            width: listView.parent.width - elementLeftMargin - elementRightMargin
            height: root.elementHeight
            radius: root.highlightRadius
            color: root.highlightColor
            opacity: root.highlightColorOpacity
            Behavior on y { NumberAnimation { duration: 300 }}
        }
        highlightFollowsCurrentItem: false
        section.property: "type"
        section.criteria: ViewSection.FullString
        section.delegate: Rectangle {
            width: parent.width; height: 40
            color: "transparent"
            Rectangle{
                width: parent.width - parent.height/2; height: 1
                anchors.centerIn: parent
                color: AppStyle.foreground
                opacity: AppStyle.emphasis.disabled
            }
        }

        onCurrentIndexChanged:{ root.currentIndexChanged(currentIndex) }
    }
}
