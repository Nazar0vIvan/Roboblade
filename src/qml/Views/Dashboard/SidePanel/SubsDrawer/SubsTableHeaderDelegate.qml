import QtQuick 2.12
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

import QtQuick.Controls.Basic

import qml.Modules.Styles 1.0

Item{
  id: control

  property bool checkable: false
  property bool checked: false
  property alias text: txt.text
  property alias textColor: txt.color
  property alias font: txt.font
  property bool isExclusiveSelection: false

  signal clicked()

  RowLayout{
    id: controlRL

    anchors{ fill: parent; leftMargin: control.checkable ? 10 : 0 }
    spacing: 10

    Text{
      id: txt

      Layout.fillWidth: true; Layout.preferredHeight: control.height
      verticalAlignment: Text.AlignVCenter
      color: Styles.foreground.high
      font: Styles.fonts.caption
    }
  }

  /// CHECKBOX LOADER ### ///
  Loader{
    id: checkboxLoader

    Component.onCompleted: {
      if(control.checkable){
        sourceComponent = checkboxComponent
        controlRL.children[0] = checkboxLoader.item
        controlRL.children.push(txt)
      }
    }
  }
  Component{
    id: checkboxComponent

    AbstractButton{
      id: checkbox

      implicitWidth: 18; implicitHeight: 18
      checkable: true
      checked: control.checked
      visible: !isExclusiveSelection && checkable

      contentItem: Rectangle{
        anchors.verticalCenter: parent.verticalCenter
        implicitWidth: 16; implicitHeight: implicitWidth
        color: checkbox.checked ? Styles.secondary.base : "transparent"
        border{ width: 1; color: "gray" }

        Image {
          anchors.centerIn: parent
          width: 10; height: width
          source: "/dashboard/tick.svg"
          fillMode: Image.PreserveAspectFit
          smooth: true
          mipmap: true
          visible: checkbox.checked
        }
      }

      onClicked: mouse => control.clicked()
    }
  }
  /// ### ///
}


