import QtQuick 2.12
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.2

import AppStyle 1.0
import Components 1.0

Rectangle{
    id: root

    signal currentIndexChanged(int index)

    clip: true

    NavigationMenu{
        id: navigationMenu

        anchors.fill: parent
        model: ListModel {
            ListElement{ iconPath: "/navigation/dashboard.svg" }
            ListElement{ iconPath: "/navigation/scene.svg"     }
            ListElement{ iconPath: "/navigation/network.svg"   }
            ListElement{ iconPath: "/navigation/settings.svg"; type: "second" }
        }

        onCurrentIndexChanged: index => { root.currentIndexChanged(index) }
    }
}
