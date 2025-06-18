import QtQuick 2.12
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.2

import qml.Modules.Styles 1.0
import qml.Modules.Components 1.0

Rectangle{
  id: root

  property int currentIndex: 0

  QxNavigationMenu{
    id: navigationMenu

    anchors.fill: parent

    model: ListModel {
      ListElement{ iconPath: "/navigation/dashboard.svg" }
      ListElement{ iconPath: "/navigation/scene.svg"     }
      ListElement{ iconPath: "/navigation/network.svg"   }
      ListElement{ iconPath: "/navigation/settings.svg"; type: "second" }
    }

    onCurrentIndexChanged: index => { root.currentIndex = index }
  }
}
