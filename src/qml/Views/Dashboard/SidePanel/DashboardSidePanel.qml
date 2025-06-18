import QtQuick 2.12
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQml.Models 2.15

import qml.Modules.Styles 1.0
import qml.Modules.Components 1.0
import qml.Modules.Widgets 1.0

Rectangle{
  id: root

  signal selectionChanged(var wgt)

  ColumnLayout{
    id: rootCL

    anchors.fill: parent

    TabBar{
      id: tabBar

      property int interval: 15

      Layout.fillWidth: true; Layout.preferredHeight: 45
      leftPadding: 20
      spacing: 15

      background: Rectangle{
        color: "transparent"
        Rectangle{
          anchors.bottom: parent.bottom; anchors.bottomMargin: -1
          width: parent.width; height: 1
          color: "#353535"
        }
      }

      QxTabButton{
        id: propsTabButton

        anchors{ verticalCenter: parent.verticalCenter }
        width: implicitWidth; height: tabBar.height
        text: qsTr("Properties")

      }
      QxTabButton{
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

        // Layout.fillWidth: true; Layout.fillHeight: true
      }
      SubsTab{
        id: subsTab

        // Layout.fillWidth: true; Layout.fillHeight: true
      }
    }
  }

  Component.onCompleted:{
    root.selectionChanged.connect(subsTab.slotSelectionChanged)
    root.selectionChanged.connect(propsTab.slotSelectionChanged)
  }
}
