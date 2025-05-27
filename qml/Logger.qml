import QtQuick 2.12
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.2

import AppStyles 1.0

Item {
  id: root

  Rectangle {
    anchors.fill: parent
    color: Styles.background.dp00

    ColumnLayout {
      anchors.fill: parent
      Label {
        text: "Log"
        Layout.fillWidth: true; Layout.preferredHeight: 30
        leftPadding: 10
        color: Styles.foreground.high
        font: Styles.fonts.body
        background: Rectangle {
          color: Styles.background.dp01;
        }
        verticalAlignment: Text.AlignVCenter
      }
      TextArea {
        id: textArea

        Layout.fillWidth: true; Layout.fillHeight: true
        color: Styles.foreground.high
        readOnly: true
        selectByMouse: true
        selectionColor: Styles.primary.transparent
        font: Styles.fonts.log
        background: Rectangle{ color: Styles.background.dp00 }
      }
      Connections {
        target: logger
        function onLogAdded(message){ textArea.append(message) }
      }
    }
  }
}
