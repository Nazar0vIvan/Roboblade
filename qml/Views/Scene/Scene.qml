import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.15
import Qt.labs.settings 1.0

import AppStyles 1.0
import Components 1.0

Item{
  id: root

  Rectangle{
    id: pane

    anchors{ fill: parent; topMargin: 2 }
    color: Styles.background.dp00

    ListView{
      id: lv

      anchors{ fill: parent; margins: 10 }
      model: ["3D", "RSI on/off"]

      delegate: Text{
        color: Styles.foreground.high
        text: modelData
      }
    }
  }



}


