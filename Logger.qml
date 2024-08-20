import QtQuick 2.12
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.2

import AppStyle 1.0

Item {
  id: root

  Rectangle{
    anchors.fill: parent
    color: AppStyle.background.dp00

    ColumnLayout{
      anchors.fill: parent
      Label{
        text: "Log"
        Layout.fillWidth: true; Layout.preferredHeight: 30
        leftPadding: 10
        color: AppStyle.foreground.high
        font: AppStyle.fonts.body
        background: Rectangle {
          color: AppStyle.background.dp01;
          opacity: AppStyle.foreground.medium
        }
        verticalAlignment: Text.AlignVCenter
      }
      TextArea{
        id: textArea

        Layout.fillWidth: true; Layout.fillHeight: true
        color: AppStyle.foreground.high
        readOnly: true
        selectByMouse: true
        selectionColor: AppStyle.primary.transparent
        font: AppStyle.fonts.log
        background: Rectangle{ color: AppStyle.background.dp00 }
      }
      Connections{
        target: logger
        function onLogAdded(message){ textArea.append(message) }
      }
    }
  }
}
