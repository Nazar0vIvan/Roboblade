import QtQuick
import QtQuick.Controls

import qml.Modules.Styles 1.0
import qml.Modules.Components 1.0

ApplicationWindow {
  id: app

  width: 1100; height: 650
  title: qsTr("Roboblade")
  visible: true

  QxButton {
    width: 50; height: 50
  }
}
