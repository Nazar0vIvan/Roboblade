import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.15
import QtQml.Models 2.15

import AppStyles 1.0

Item {
  id: root

  property alias titleName: titleName.text
  readonly property int titleHeight: 30
  property alias titleSpacing: rootCL.spacing

  required property int componentHeight
  required property int labelWidth
  required property int fieldWidth
  required property list<Item> components

  property alias componentsSpacing: fieldsCL.spacing
  property int componentSpacing: 0

  implicitHeight: childrenRect.height

  ColumnLayout{
    id: rootCL

    width: parent.width
    spacing: 20

    Text{
      id: titleName

      Layout.fillWidth: true; Layout.preferredHeight: titleHeight
      Layout.alignment: Qt.AlignVCenter
      verticalAlignment: Text.AlignVCenter
      color: Styles.foreground.high
      font: Styles.fonts.headline2
    }

    ColumnLayout{
      id: fieldsCL

      Layout.fillWidth: true
      spacing: 5

      Component.onCompleted: {
        for(let i = 0; i < components.length; ++i){
          components[i].parent = fieldsCL
          components[i].Layout.preferredHeight = root.componentHeight
          components[i].labelWidth = root.labelWidth
          components[i].spacing = root.componentSpacing

          components[i].field.Layout.preferredHeight = root.componentHeight
          components[i].field.Layout.preferredWidth = root.fieldWidth
        }
      }
      /*
            Repeater{
                id: repeater

                model: root.objectModel
                Component.onCompleted:{
                    for(var i = 0; i < root.objectModel.count; i++){
                        root.objectModel.get(i).Layout.fillWidth = true
                        root.objectModel.get(i).Layout.preferredHeight = root.fieldHeight
                    }
                }
            }
            */
    }

    // separator
    Rectangle{
      id: separator

      Layout.fillWidth: true; Layout.preferredHeight: 1; Layout.rightMargin: 16
      color: Styles.foreground.disabled
    }
  }

}
