import QtQuick 2.12
import QtQuick.Controls 2.15
import Qt5Compat.GraphicalEffects

import Components 1.0
import AppStyle 1.0

Menu{
  delegate: MenuItem{
    id: menuItem

    implicitWidth: 180; implicitHeight: 35
    leftPadding: 0

    indicator: Item {
      implicitWidth: 28; implicitHeight: implicitWidth
      anchors.verticalCenter: parent.verticalCenter
      Image {
        width: 15; height: width
        anchors.centerIn: parent
        source: menuItem.icon.source
        fillMode: Image.PreserveAspectFit
        smooth: true
        mipmap: true

        Colorize{
          anchors.fill: parent

          source: parent
          saturation: 0.0
          visible: !menuItem.enabled
        }
      }

    }
    contentItem: Text {
      leftPadding: menuItem.icon.source ? menuItem.indicator.width : 0
      verticalAlignment: Text.AlignVCenter
      text: menuItem.text
      font: AppStyle.fonts.caption
      color: parent.enabled ? AppStyle.foreground.high : AppStyle.foreground.disabled
    }
    background: Rectangle {
      color: menuItem.hovered ? AppStyle.primary.transparent : AppStyle.background
    }
  }

  background: Rectangle {
    implicitWidth: 180; implicitHeight: 30
    color: AppStyle.background.dp00
    border{ width: 1; color: "gray" }
  }
}
