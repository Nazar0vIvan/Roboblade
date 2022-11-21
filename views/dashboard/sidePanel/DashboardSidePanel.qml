import QtQuick 2.12
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQml.Models 2.15

import AppStyle 1.0
import Components 1.0
import Widgets 1.0

Rectangle{
    id: root

    function slotSelectionChanged(wgt){
        if(wgt !== null){
            propsTab.setModel(wgt)
            subsTab.enabled = true
        }
        else {
            propsTab.model = null
            subsTab.enabled = false
        }
    }

    signal subsPopupStateChanged()

    ColumnLayout{
        id: rootCL

        anchors.fill: parent

        TabBar{
            id: tabBar

            property int interval: 15

            Layout.fillWidth: true; Layout.preferredHeight: 35
            leftPadding: 15
            spacing: 15

            background: Rectangle{
                color: "transparent"
//                Rectangle{
//                    anchors.bottom: parent.bottom
//                    width: parent.width; height: 1
//                    color: AppStyle.foreground
//                    opacity: AppStyle.emphasis.disabled
//                }
            }

            AppTabButton{
                id: propsTabButton

                anchors{ verticalCenter: parent.verticalCenter }
                width: implicitWidth; height: tabBar.height
                text: qsTr("Properties")

            }
            AppTabButton{
                id: subsTabButton

                anchors.verticalCenter: parent.verticalCenter
                width: implicitWidth; height: tabBar.height
                text: qsTr("Subscriptions")
            }
        }

        StackLayout{
            id: drawerStackLayout

            Layout.fillWidth: true; Layout.fillHeight: true
            currentIndex: tabBar.currentIndex

            PropsTab{
                id: propsTab

                Layout.fillWidth: true; Layout.fillHeight: true

            }
            SubsTab{
                id: subsTab

                Layout.fillWidth: true; Layout.fillHeight: true

                onSubsPopupStateChanged: { root.subsPopupStateChanged(); isSubsPopupOpen = !isSubsPopupOpen }


            }
        }
    }
}
