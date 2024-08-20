import QtQuick 2.12
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

import AppStyle 1.0
import Components 1.0

import "subsDrawer"

Item{
  id: root

  function slotSelectionChanged(wgt){
    if(wgt !== null){
      subsDrawer.widget = wgt
      subsButton.enabled = true
    }
    else{
      subsButton.enabled = false
    }
  }

  ColumnLayout{
    id: rootCL

    anchors.fill: parent

    Rectangle{
      id: subsInfo

      Layout.fillWidth: true; Layout.fillHeight: true
      color: "transparent"
    }

    AppButton{
      id: subsButton

      Layout.preferredHeight: 30;  Layout.preferredWidth: 100;
      Layout.alignment: Qt.AlignLeft
      Layout.bottomMargin: 10; Layout.leftMargin: 10
      leftPadding: 10
      text: qsTr("Subscribe")
      font: AppStyle.fonts.caption
      backgroundColor: AppStyle.secondary.base
      color: AppStyle.background.dp00
      hoverEnabled: enabled
      enabled: false

      iconSize: 16
      iconPath: "/dashboard/arrow_left.png"
      iconColor: enabled ? "black" : "gray"

      onClicked: subsDrawer.visible ? subsDrawer.close() : subsDrawer.open()
      onHoveredChanged: shiftAnimation.start()

      NumberAnimation{
        id: shiftAnimation

        target: subsButton.contentItem.icon
        from: subsButton.hovered ? -subsButton.iconSize/3 : 0
        to:   subsButton.hovered ? 0 : -subsButton.iconSize/3
        property: "x";
        duration: 200
      }
    }
  }

  SubsDrawer{
    id: subsDrawer

    y: 80
    width: 550; height: parent.height - y - 5
  }
}
