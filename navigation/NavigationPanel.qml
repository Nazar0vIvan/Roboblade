import QtQuick 2.12
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.2

import AppStyle 1.0
import Components 1.0

Rectangle{
    id: root

    property alias txtLogoOpacity: logo.txtOpacity

    signal currentIndexChanged(int index)

    clip: true


    ColumnLayout{
        id: rootCL

        anchors.fill: parent

        Logo{
            id: logo

            Layout.preferredWidth: parent.width; Layout.preferredHeight: 90
        }

        NavigationMenu{
            id: navigationMenu

            Layout.fillWidth: true; Layout.fillHeight: true
            font: AppStyle.fonts.title
            model: ListModel {
                ListElement{ name: "Dashboard"; iconPath: "/navigation/dashboard.svg" }
                ListElement{ name: "Scene";     iconPath: "/navigation/scene.svg" }
                ListElement{ name: "Network";   iconPath: "/navigation/network.svg" }
                ListElement{ name: "Settings";  iconPath: "/navigation/settings.svg"; type: "second" }
                ListElement{ name: "Help";      iconPath: "/navigation/help.svg";     type: "second" }
            }

            onCurrentIndexChanged: index => { root.currentIndexChanged(index) }
        }
    }
}
