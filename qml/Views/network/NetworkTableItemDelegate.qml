import QtQuick 2.12
import QtQuick.Controls 2.15

import AppStyles 1.0

ItemDelegate{
  id: control

  property real overlayOpacity: 0.0
  property color color: Styles.foreground.high

  contentItem: Text{
    verticalAlignment: Text.AlignVCenter
    text: control.text
    font: control.font
    color: control.color
  }

  background: Rectangle{
    color: Styles.foreground.high
    opacity: control.overlayOpacity
  }
}
