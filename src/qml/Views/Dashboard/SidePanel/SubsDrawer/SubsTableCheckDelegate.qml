import QtQuick 2.12
import QtQuick.Controls 2.15

import qml.Modules.Styles 1.0

CheckDelegate{
  id: control

  property real overlayOpacity: 0.0
  property color color: Styles.foreground.high

  property int _spacing: 10

  font: Styles.fonts.body

  leftPadding: indicator.implicitWidth + 2*_spacing

  contentItem: Text{
    anchors.verticalCenter: parent.verticalCenter
    text: control.text
    font: control.font
    color: control.color
  }

  indicator: Rectangle{
    anchors{ left: parent.left; leftMargin: _spacing; verticalCenter: parent.verticalCenter }
    implicitWidth: 16; implicitHeight: implicitWidth
    color: control.checked ? Styles.secondary.base : "transparent"
    border{ width: 1; color: control.checked ? Styles.secondary.base : "gray" }

    Image{
      anchors.centerIn: parent
      width: 10; height: width
      source: "/dashboard/tick.svg"
      fillMode: Image.PreserveAspectFit
      smooth: true
      mipmap: true
      visible: control.checked
    }
  }

  background: Rectangle {
    color: Styles.foreground.high
    opacity: control.overlayOpacity
  }
}
