import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0

import qml.Modules.Styles 1.0
import qml.Modules.Components 1.0

import "./Navigation"
import "./Views/Settings"
import "./Views/Dashboard"
import "./Views/Network"
import "./Views/Scene"

ApplicationWindow{
  id: app

  width: 1100; height: 650
  color: Styles.background.dp01
  title: qsTr("Roboblade")
  visible: true

  menuBar: QxMenuBar{ height: 30 }

  SplitView{ // top - logger
    id: verticalSV

    anchors.fill: parent
    orientation: Qt.Vertical
    handle: Rectangle {
      implicitHeight: 1
      // color: SplitHandle.pressed | SplitHandle.hovered ? Styles.foreground.high : "transparent"
      color: Styles.background.dp04
      // opacity: SplitHandle.pressed ? Styles.emphasis.high : (SplitHandle.hovered ? Styles.emphasis.medium : 1.0)
    }

    SplitView{ // navigation nav - view
      id: horiznotalSV

      SplitView.fillWidth: true; SplitView.fillHeight: true
      orientation: Qt.Horizontal
      handle: Rectangle {
        implicitWidth: 1
        //color: SplitHandle.pressed | SplitHandle.hovered ? Styles.foreground.high : "transparent"
        color: Styles.background.dp04
      }

      NavigationPanel{
        id: navigationPanel

        SplitView.preferredWidth: 50; SplitView.fillHeight: true
        SplitView.minimumWidth: 50; SplitView.maximumWidth: 50
        color: Styles.background.dp00
      }

      StackLayout{
        id: sl

        SplitView.fillHeight: true; SplitView.fillWidth: true

        currentIndex: navigationPanel.currentIndex

        Dashboard{ id: dashboard }

        Scene{ id: scene }

        Network{ id: network;  }

        SettingsView{ id: settingsView }
      }
    }

    Logger{
      SplitView.fillWidth: true; SplitView.preferredHeight: 0
      SplitView.maximumHeight: 200
    }
  }
}
