import QtQuick
import QtQuick.Controls

import Modules.Components 1.0

ApplicationWindow {
  id: app

  width: 1100; height: 650
  title: qsTr("Roboblade")
  visible: true

  Rectangle {
    width: 50; height: 50
    color: "red";
  }
}
