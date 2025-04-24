import QtQuick
import QtQuick.Controls

import qml.Styles 1.0
import qml.Components 1.0

ApplicationWindow {
  id: app

  width: 1100; height: 650
  title: qsTr("Roboblade")
  visible: true
  color: Styles.background.dp24

  menuBar: AppMenuBar{ height: 30 }
/*
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
  */
}
