import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.15
import Qt.labs.settings 1.0

import AppStyles 1.0
import Components 1.0

Item{
  id: root

  signal gridStepChanged(int step)

  Rectangle{
    id: pane

    anchors{ fill: parent; topMargin: 2 }
    color: Styles.background.dp00

    //    required property Loader settingsWindowLoader
    //    property var signals: new Map() // map settings_name -> settings_value, e.g. "Local Port" -> "2222"

    ColumnLayout{
      id: rootCL

      anchors{
        fill: parent
        topMargin: 10
        leftMargin: 20
        rightMargin: 20
        bottomMargin: 10
      }
      spacing: 20

      Text{
        text: qsTr("Settings")
        font: Styles.fonts.headline1
        color: Styles.foreground.high
      }

      // -> TabBar
      TabBar{
        id: tabBar

        property int interval: 35

        Layout.fillWidth: true; Layout.preferredHeight: 35
        spacing: 0
        background: Rectangle{
          color: "transparent"
          Rectangle{
            anchors.bottom: parent.bottom
            width: parent.width; height: 1
            color: Styles.foreground.disabled
          }
        }
        AppTabButton{
          id: dashboardTabButton

          anchors.verticalCenter: parent.verticalCenter
          width: tabBar.interval + dashboardTabButton.contentItem.implicitWidth
          height: 35
          text: qsTr("Dashboard")
        }

        AppTabButton{
          id: settingsTabButton

          anchors.verticalCenter: parent.verticalCenter
          width: tabBar.interval + settingsTabButton.contentItem.implicitWidth
          height: 35
          text: qsTr("Network")
        }
        AppTabButton{
          id: sceneTabButton

          anchors.verticalCenter: parent.verticalCenter
          width: tabBar.interval + sceneTabButton.contentItem.implicitWidth
          height: 35
          text: qsTr("Scene")
        }
        AppTabButton{
          id: mdlTabButton

          anchors.verticalCenter: parent.verticalCenter
          width: tabBar.interval + mdlTabButton.contentItem.implicitWidth
          height: 35
          text: qsTr("Model")
        }
      }
      // <- TabBar

      StackLayout{
        id: stgViewSL

        currentIndex: tabBar.currentIndex

        SettingsDashboardTab{ id: stgDashboardTab }

        SettingsNetworkTab{ id: stgNetworkTab }

        Rectangle{ id: stgSceneTab }

        Rectangle{ id: stgModelTab }
      }

      RowLayout{
        id: buttonsRL

        Layout.fillWidth: true; Layout.fillHeight: true
        Layout.alignment: Qt.AlignBottom | Qt.AlignRight
        Layout.rightMargin: 16

        AppButton{
          id: defaultButton

          Layout.preferredWidth: 80; Layout.preferredHeight: 30
          type: Styles.ButtonType.Outlined
          text: "Default"
          onClicked: {}
        }
        AppButton{
          id: applyButton

          Layout.preferredWidth: 80; Layout.preferredHeight: 30
          backgroundColor: Styles.secondary.base
          type: Styles.ButtonType.Contained
          color: Styles.background.dp00
          text: "Apply"
          onClicked: {
            // for (const v1 of stgDashboardTab.signals.values()){ v1.signal(v1.arg) }
            for (const v2 of stgNetworkTab.signals.values()) v2.signal(v2.arg)
            // stgDashboardTab.signals.clear()
            stgNetworkTab.signals.clear()

          }
        }
      }
    }

  }
}




