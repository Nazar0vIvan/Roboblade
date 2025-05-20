import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.2
import Qt5Compat.GraphicalEffects

import AppStyles 1.0
import Widgets 1.0
import Components 1.0
import Properties 1.0

Rectangle{
  id: root

  property int size: 22
  property var signals: new Map()

  property int  _popupLabelWidth: 80
  property int  _popupFieldWidth: 130
  property int  _popupComponentHeight: 25
  property int  _popupComponentSpacing: 0
  property int  _popupSpacing: 5
  property font _popupFont: Styles.fonts.caption

  signal grid
  signal snap
  signal fullscreen

  signal gridStepChanged(int step)
  signal gridOpacityChanged(double opacity)
  signal gridLineTypeChanged(int type)
  signal gridLineColorChanged(string color)
  signal gridLineWidthChanged(int width)
  signal snapSpacingChanged(int step)

  function addToSnaps(button){ dragModes.addButton(button) }

  Action{ id: none }
  Action{ id: grid; shortcut: "G"; onCheckedChanged:{ root.grid() } checkable: true }
  Action{ id: snap; shortcut: "B"; onCheckedChanged:{ root.snap() } checkable: true }
  Action{ id: fullscreen; shortcut: StandardKey.FullScreen; onTriggered:{ root.fullscreen(); console.log("fullscreen") } }

  ButtonGroup{ id: dragModes }

  AppPopup{ id: noPopup }

  AppPopup{
    id: gridPopup

    componentHeight: _popupComponentHeight; font: _popupFont; spacing: _popupSpacing;
    labelWidth: _popupLabelWidth; fieldWidth: _popupFieldWidth; componentSpacing: _popupComponentSpacing
    components:[
      AppFormComponent{
        id: gridStep;
        labelName: qsTr("Step");
        field: AppTextField{
          text: "20"
          font.pixelSize: 12
          validator: IntValidator{ bottom: 0; top: 500 }
          onEditingFinished: { root.gridStepChanged(parseInt(text)) }
          Component.onCompleted: editingFinished()
        }
      },
      AppFormComponent{
        id: gridOpacity
        labelName: qsTr("Opacity")
        field: AppTextField{
          text: "10%"
          font.pixelSize: 12
          validator: IntValidator{ bottom: 0; top: 100 }
          onEditingFinished: { root.gridOpacityChanged(parseFloat(text)); if(text.slice(-1) !== "%") text+="%" }
          Component.onCompleted: editingFinished()
        }
      },
      AppFormComponent{
        id: lineType
        labelName: qsTr("Line Type")
        field: AppComboBox{
          anchors.leftMargin: contentItem.leftPadding
          font.pixelSize: 12
          valueRole: "value"
          textRole: "text"
          model:[
            { value: Qt.SolidLine,   text: qsTr("Solid")       },
            { value: Qt.DashLine,    text: qsTr("DashLine")    },
            { value: Qt.DotLine,     text: qsTr("DotLine")     },
            { value: Qt.DashDotLine, text: qsTr("DashDotLine") }
          ]
          onEditingFinished: root.gridLineTypeChanged(currentIndex)
          Component.onCompleted: { currentIndex = indexOfValue(Qt.SolidLine); editingFinished() }
        }
      },
      AppFormComponent{
        id: lineColor
        labelName: qsTr("Line Color")
        field: ColorProperty{
          font.pixelSize: 12
          onEditingFinished: root.gridLineColorChanged(getColor())
          Component.onCompleted:{ editingFinished() }
        }
      },
      AppFormComponent{
        id: lineWidth
        labelName: qsTr("Line Width")
        field: AppTextField{
          text: "1"
          font.pixelSize: 12
          validator: IntValidator{ bottom: 0; top: 5000 }
          onEditingFinished: root.gridLineWidthChanged(parseInt(text))
          Component.onCompleted: editingFinished()
        }
      }
    ]
  }

  AppPopup{
    id: snapPopup

    componentHeight: _popupComponentHeight; font: _popupFont; spacing: _popupSpacing;
    labelWidth: _popupLabelWidth; fieldWidth: _popupFieldWidth; componentSpacing: _popupComponentSpacing
    components:[
      AppFormComponent{
        id: snapStep;
        labelName: qsTr("Step");
        field: AppTextField{
          text: "10"
          font.pixelSize: 12
          validator: IntValidator{ bottom: 0; top: 500 }
          onEditingFinished: root.snapSpacingChanged(parseInt(text))
        }
      }
    ]
  }

  RowLayout{
    id: rootRL

    anchors.fill: parent

    // LEFT TOOLBAR SIDE

    ListView {
      id: leftListView

      Layout.preferredWidth: contentItem.childrenRect.width; Layout.fillHeight: true
      Layout.leftMargin: 20

      orientation: Qt.Horizontal
      spacing: 12
      interactive: false

      model: ListModel{
        id: lmdl

        Component.onCompleted: {
          lmdl.append({ type: 0, iconPath: "/dashboard/numeric.svg",    todo: none,   isCheckable: false, popup: noPopup, })
          lmdl.append({ type: 1, iconPath: "/dashboard/gauge.svg",      todo: none,   isCheckable: false, popup: noPopup, })
          lmdl.append({ type: 2, iconPath: "/dashboard/table.svg",      todo: none,   isCheckable: false, popup: noPopup, })
          lmdl.append({ type: 3, iconPath: "/dashboard/line_chart.svg", todo: none,   isCheckable: false, popup: noPopup, })
          lmdl.append({ type: 4, iconPath: "/dashboard/bar_chart.svg",  todo: none,   isCheckable: false, popup: noPopup, })
          lmdl.append({ type: 5, iconPath: "/dashboard/pie_chart.svg",  todo: none,   isCheckable: false, popup: noPopup, })
          lmdl.append({ type: 6, iconPath: "/dashboard/group.svg",      todo: none,   isCheckable: false, popup: noPopup, })
          lmdl.append({ type: 7, iconPath: "/dashboard/text.svg",       todo: none,   isCheckable: false, popup: noPopup, })
          lmdl.append({ type: 9, iconPath: "/dashboard/grid.svg",       todo: grid,   isCheckable: true,  popup: gridPopup, section: "dragMode" })
          lmdl.append({ type: 9, iconPath: "/dashboard/snap.svg",       todo: snap,   isCheckable: true,  popup: snapPopup, section: "dragMode" })
        }
      }

      // delegate parent - contentItem of the ListView !
      delegate: AppToolButton{

        required property string section
        required property var popup

        anchors.verticalCenter: parent ? parent.verticalCenter : undefined
        toolBar: root
        size: root.size
        isDropDown: popup.components.length
      }
      section.property: "section"
      section.criteria: ViewSection.FullString
      section.delegate: Rectangle{
        width: leftListView.spacing; height: root.size
        anchors.verticalCenter: parent.verticalCenter
        color: "transparent"
        Rectangle{
          width: 1; height: parent.height
          anchors.verticalCenter: parent.verticalCenter
          color: Styles.foreground.disabled
          anchors.left: parent.left
        }
      }
    }

    Rectangle { Layout.fillWidth: true } // spacer

    // RIGHT TOOLBAR SIDE

    //        ListView {
    //           id: rightListView

    //           Layout.preferredWidth: contentItem.childrenRect.width; Layout.fillHeight: true
    //           Layout.rightMargin: 20
    //           orientation: Qt.Horizontal
    //           spacing: 0
    //           interactive: false

    //           model: ListModel{
    //               id: rmdl

    //               Component.onCompleted: {
    //                   rmdl.append({ type: 9, iconPath: "/dashboard/fullscreen.svg", todo: fullscreen, isCheckable: false, popup: noPopup, section: "right"})
    //               }
    //           }
    //           delegate: AppToolButton{
    //               anchors{ bottom: parent.bottom; bottomMargin: 8 }
    //               toolBar: root
    //               size: root.size
    //           }
    //        }
  }
}


