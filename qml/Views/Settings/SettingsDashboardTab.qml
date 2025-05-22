import QtQuick 2.15
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.15
import QtQml.Models 2.15

import AppStyles 1.0
import Components 1.0
import Properties 1.0

ListView {
  id: root

  property int maxAvailableWidth: root.contentWidth - root.width
  property int maxAvailableHeight: root.contentHeight - root.height

  readonly property int _componentHeight: 30
  readonly property int _componentsSpacing: 10

  readonly property int _labelWidth: 90
  readonly property int _fieldWidth: 200
  readonly property int _componentSpacing: 0

  property var signals: new Map()

  spacing: 20
  clip: true
  boundsBehavior: Flickable.StopAtBounds

  model: ObjectModel{

  }
}

/*

SettingsSection{
    id: grid

    width: root.width
    titleName: qsTr("Grid")
    componentHeight: _componentHeight; componentsSpacing: _componentsSpacing;
    labelWidth: _labelWidth; fieldWidth: _fieldWidth; componentSpacing: _componentSpacing
    components:[
        AppFormComponent{
            id: gridStep;
            labelName: qsTr("Step")
            field: AppTextField{
                text: "10"
                validator: portValidator
                onEditingFinished:{ signals.set(1, {signal: root.gridStepChanged, arg: text}) }
            }
        },
        AppFormComponent{
            id: lineType
            labelName: qsTr("Line Type")
            field: AppComboBox{
                anchors.leftMargin: contentItem.leftPadding
                valueRole: "value"
                textRole: "text"
                model:[
                    { value: Qt.SolidLine,   text: qsTr("Solid")       },
                    { value: Qt.DashLine,    text: qsTr("DashLine")    },
                    { value: Qt.DotLine,     text: qsTr("DotLine")     },
                    { value: Qt.DashDotLine, text: qsTr("DashDotLine") },
                ]
                Component.onCompleted: { currentIndex = indexOfValue(Qt.SolidLine) }
                onEditingFinished:{ signals.set(2, {signal: root.gridLineTypeChanged, arg: currentValue}) }
            }
        },
        AppFormComponent{
            id: lineColor
            labelName: qsTr("Line Color")
            field: ColorProperty{
                onEditingFinished:{ signals.set(3, {signal: root.gridLineColorChanged, arg: text}) }
            }
        },
        AppFormComponent{
            id: lineWidth
            labelName: qsTr("Line Width")
            field: AppTextField{
                text: "1"
                validator: portValidator
                onEditingFinished:{ signals.set(4, {signal: root.gridLineWidthChanged, arg: text}) }
            }
        }
    ]
}

SettingsSection{
    id: snap

    width: root.width
    titleName: qsTr("Snap Mode")
    componentHeight: _componentHeight; componentsSpacing: _componentsSpacing;
    labelWidth: _labelWidth; fieldWidth: _fieldWidth; componentSpacing: _componentSpacing

    components:[
        AppFormComponent{
            id: snapSpacing
            labelName: qsTr("Spacing")
            field: AppTextField{
                text: "1"
                validator: portValidator
                onEditingFinished:{ signals.set(5, {signal: root.snapStepChanged, arg: text}) }
            }
        }
    ]
}

*/
