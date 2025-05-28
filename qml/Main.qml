import QtQuick
import QtQuick.Controls

import Modules.Components 1.0
import Modules.Styles 1.0 as Styles

ApplicationWindow {
  id: app

  width: 1100; height: 650
  title: qsTr("Roboblade")
  visible: true

  Rectangle {
    width: 50; height: 50
    color: Styles.minColor
  }

  AppRectangle {
    id: bok
  }

}
