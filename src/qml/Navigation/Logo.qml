import QtQuick 2.12
import QtQuick.Layouts 1.2

import qml.Modules.Styles 1.0

Item{
  id: root

  property alias txtOpacity: txtLogoCL.opacity

  RowLayout{
    id: rootRL

    anchors{ fill: parent; leftMargin: 18 }
    spacing: 5

    Image{
      Layout.preferredWidth: 50; Layout.preferredHeight: 50
      source: "/main/logo.svg"
      mipmap: true
    }
    ColumnLayout{
      id: txtLogoCL

      Layout.fillWidth: true; Layout.fillHeight: true
      spacing: 5

      Text{
        id: txt

        width: parent.width
        Layout.preferredWidth: 70
        text: "RoboBlade"
        color: Styles.foreground.high
        font: Styles.fonts.logo
      }
      TextMetrics {
        id: txtMetricsLogo

        font: txt.font
        text: txt.text
      }
      RowLayout{
        id: underlinesRL

        Layout.preferredWidth: txtMetricsLogo.boundingRect.width; Layout.preferredHeight: 1
        Layout.maximumWidth: txtMetricsLogo.boundingRect.width

        Rectangle{
          id: orange

          implicitWidth: 33
          Layout.fillWidth: true; Layout.preferredHeight: 1
          Layout.minimumWidth: orange.implicitWidth
          color: Styles.secondary.base

        }
        Rectangle{
          id: blue

          implicitWidth: 33
          Layout.fillWidth: true; Layout.preferredHeight: 1
          Layout.minimumWidth: blue.implicitWidth
          color: Styles.primary.base
        }
        Rectangle{
          id: gray

          implicitWidth: 33
          Layout.fillWidth: true; Layout.preferredHeight: 1
          Layout.minimumWidth: gray.implicitWidth
          color: "gray"
        }
      }
    }
  }
}


