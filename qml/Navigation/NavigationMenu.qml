import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.2

import AppStyle 1.0

Item{
    id: root

    signal currentIndexChanged(int index)

    ListView{
        id: listView

        anchors{ fill: parent; leftMargin: 20; rightMargin: 20 }
        spacing: 0
        clip: true
        interactive: false
        model: ListModel {
            ListElement{ name: "Dashboard"; iconPath: "/navigation/dashboard.svg" }
            ListElement{ name: "Scene";     iconPath: "/navigation/scene.svg" }
            ListElement{ name: "Network";   iconPath: "/navigation/network.svg" }
            ListElement{ name: "Settings";  iconPath: "/navigation/settings.svg"; type: "second" }
            ListElement{ name: "Help";      iconPath: "/navigation/help.svg";     type: "second" }
        }
        delegate: NavigationMenuDelegate {
            width: root.width; height: 45
        }
        highlight: Rectangle {
            y: listView.currentItem.y
            width: listView.currentItem.width - 40; height: 45
            radius: 4
            color: AppStyle.primary.base
            opacity: 0.2
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
