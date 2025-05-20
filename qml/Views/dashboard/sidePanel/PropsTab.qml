import QtQuick 2.12
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.2
import QtQml.Models 2.15

import AppStyles 1.0
import Widgets 1.0
import Components 1.0
import Properties 1.0

ListView{
  id: root

  property var widgetTypeToModel: new Map([ [0, numericPropsObjectModel],
                                           [1, gaugePropsObjectModel],
                                           [3, lineChartPropsObjectModel],
                                           [8, defaultObjectModel]])

  function slotSelectionChanged(wgt){ if(wgt !== null) root.setModel(wgt); else root.model = null }

  function setModel(wgt){
    root.model = widgetTypeToModel.get(wgt.type)
    root.model.setWidget(wgt)
  }

  spacing: 0
  clip: true
  boundsBehavior: Flickable.StopAtBounds

  // default model
  BasePropsModel{
    id: defaultObjectModel
  }

  // numeric model
  BasePropsModel{
    id: numericPropsObjectModel

    PropertiesSection{
      id: numericBackgroundPropsSection

      titleName: qsTr("Background")
      properties:[
        ColorProperty{  id: numericBackgroundColorProp; Layout.leftMargin: -5 },
        ColorProperty{  id: numericBorderColorProp; Layout.leftMargin: -5 },
        BorderProperty{ id: numericBorderProp }
      ]
    }

    PropertiesSection{
      id: numericTitlePropsSection
      titleName: qsTr("Title")
      properties:[
        TextProperty{ id: numericTitleTextProp; Layout.leftMargin: -5 },
        ColorProperty{ id: numericTitleTextColorProp; Layout.leftMargin: -5}
      ]
    }

    PropertiesSection{
      id: numericValuePropsSection
      titleName: qsTr("Value")
      properties:[
        TextProperty{ id: numericValueTextProp; Layout.leftMargin: -5; readonly: true }
      ]
        }

          onWgtChanged:{
            if(wgt === null) return
            // background
            numericBackgroundColorProp.setColor(wgt.background.color)
            numericBorderColorProp.setColor(wgt.background.border.color)
            numericBorderProp.setRadius(wgt.background.radius)
            numericBorderProp.setLineWidth(wgt.background.border.width)

            numericBackgroundColorProp.editingFinished.connect(function(){ wgt.background.color = numericBackgroundColorProp.getColor() })
            numericBorderColorProp.editingFinished.connect(function(){ wgt.background.border.color = numericBorderColorProp.getColor() })
            numericBorderProp.radiusEditingFinished.connect(function(){ wgt.background.radius = numericBorderProp.getRadius() })
            numericBorderProp.lineWidthEditingFinished.connect(function(){ wgt.background.border.width = numericBorderProp.getLineWidth() })

            // title
            numericTitleTextProp.setText(wgt.titleText)
            numericTitleTextProp.setFamily(wgt.titleFont.family)
            numericTitleTextProp.setWeight(wgt.titleFont.weight)
            numericTitleTextProp.setPixelSize(wgt.titleFont.pixelSize)
            numericTitleTextColorProp.setColor(wgt.titleColor)

            numericTitleTextProp.textEditingFinished.connect(
                  function(){ wgt.titleText = numericTitleTextProp.getText() })
            numericTitleTextProp.familyEditingFinished.connect(
                  function(){ wgt.titleFont.family = numericTitleTextProp.getFamily() })
            numericTitleTextProp.weightEditingFinished.connect(
                  function(){ wgt.titleFont.weight = numericTitleTextProp.getWeight() })
            numericTitleTextProp.pixelSizeEditingFinished.connect(
                  function(){ wgt.titleFont.pixelSize = numericTitleTextProp.getPixelSize() })
            numericTitleTextColorProp.editingFinished.connect(
                  function(){ wgt.titleColor = numericTitleTextColorProp.getColor() })

            // value
            numericValueTextProp.setFamily(wgt.valueFont.family)
            numericValueTextProp.setWeight(wgt.valueFont.weight)
            numericValueTextProp.setPixelSize(wgt.valueFont.pixelSize)

            numericValueTextProp.familyEditingFinished.connect(
                  function(){ wgt.valueFont.family = numericValueTextProp.getFamily() })
            numericValueTextProp.weightEditingFinished.connect(
                  function(){ wgt.valueFont.weight = numericValueTextProp.getWeight() })
            numericValueTextProp.pixelSizeEditingFinished.connect(
                  function(){ wgt.valueFont.pixelSize = numericValueTextProp.getPixelSize() })
          }
        }

        BasePropsModel{
          id: gaugePropsObjectModel

          PropertiesSection{
            id: gaugeBackgroundPropsSection

            titleName: qsTr("Background")
            properties:[
              ColorProperty{ id: gaugeBackgroundColorProp; Layout.leftMargin: -5 },
              ColorProperty{ id: gaugeBorderColorProp; Layout.leftMargin: -5 },
              BorderProperty{ id: gaugeBorderProp }
            ]
          }

          PropertiesSection{
            id: gaugeTitlePropsSection
            titleName: qsTr("Title")
            properties:[
              TextProperty{ id: gaugeTitleTextProp; Layout.leftMargin: -5 },
              ColorProperty{ id: gaugeTitleTextColorProp; Layout.leftMargin: -5}
            ]
          }
          PropertiesSection{
            id: gaugeValuePropsSection
            titleName: qsTr("Value")
            properties:[
              TextProperty{ id: gaugeValueTextProp; Layout.leftMargin: -5; readonly: true }
            ]
              }

                onWgtChanged:{
                  if(wgt === null) return
                  // background
                  gaugeBackgroundColorProp.setColor(wgt.background.color)
                  gaugeBorderColorProp.setColor(wgt.background.border.color)
                  gaugeBorderProp.setRadius(wgt.background.radius)
                  gaugeBorderProp.setLineWidth(wgt.background.border.width)

                  gaugeBackgroundColorProp.editingFinished.connect(function(){ wgt.background.color = gaugeBackgroundColorProp.getColor() })
                  gaugeBorderColorProp.editingFinished.connect(function(){ wgt.background.border.color = gaugeBorderColorProp.getColor() })
                  gaugeBorderProp.radiusEditingFinished.connect(function(){ wgt.background.radius = gaugeBorderProp.getRadius() })
                  gaugeBorderProp.lineWidthEditingFinished.connect(function(){ wgt.background.border.width = gaugeBorderProp.getLineWidth() })

                  // title
                  gaugeTitleTextProp.setText(wgt.titleText)
                  gaugeTitleTextProp.setFamily(wgt.titleFont.family)
                  gaugeTitleTextProp.setWeight(wgt.titleFont.weight)
                  gaugeTitleTextProp.setPixelSize(wgt.titleFont.pixelSize)
                  gaugeTitleTextColorProp.setColor(wgt.titleColor)

                  gaugeTitleTextProp.textEditingFinished.connect(
                        function(){ wgt.titleText = gaugeTitleTextProp.getText() })
                  gaugeTitleTextProp.familyEditingFinished.connect(
                        function(){ wgt.titleFont.family = gaugeTitleTextProp.getFamily() })
                  gaugeTitleTextProp.weightEditingFinished.connect(
                        function(){ wgt.titleFont.weight = gaugeTitleTextProp.getWeight() })
                  gaugeTitleTextProp.pixelSizeEditingFinished.connect(
                        function(){ wgt.titleFont.pixelSize = gaugeTitleTextProp.getPixelSize() })
                  gaugeTitleTextColorProp.editingFinished.connect(
                        function(){ wgt.titleColor = gaugeTitleTextColorProp.getColor() })

                  // value
                  gaugeValueTextProp.setFamily(wgt.valueFont.family)
                  gaugeValueTextProp.setWeight(wgt.valueFont.weight)
                  gaugeValueTextProp.setPixelSize(wgt.valueFont.pixelSize)

                  gaugeValueTextProp.familyEditingFinished.connect(
                        function(){ wgt.valueFont.family = gaugeValueTextProp.getFamily() })
                  gaugeValueTextProp.weightEditingFinished.connect(
                        function(){ wgt.valueFont.weight = gaugeValueTextProp.getWeight() })
                  gaugeValueTextProp.pixelSizeEditingFinished.connect(
                        function(){ wgt.valueFont.pixelSize = gaugeValueTextProp.getPixelSize() })
                }


              }

              // line chart
              BasePropsModel{
                id: lineChartPropsObjectModel

                /*
        onWgtChanged:{
            lineChartTitleProp.wgt = lineChartModel.wgt

            lineChartAxisXProp.wgt = lineChartModel.wgt
        }


        PropertiesSection{
            id: propsSectionLineChartTitle
            titleName: qsTr("Title")
            properties:[
                TextProperty{ id: lineChartTitleProp }
            ]
        }

        PropertiesSection{
            id: propsSectionLineChartAxisX
            titleName: qsTr("Axis X")
            properties:[
                TextProperty{ id: lineChartAxisXProp },
                AppFieldText{ id: lineChartAxisXStepProp; labelName: "step"; labelWidth: 100; txtFieldWidth: 60; spacing: 0 }
            ]
        }

        PropertiesSection{
            id: propsSectionLineChartAxisY
            titleName: qsTr("Axis Y")
            properties:[
                TextProperty{ id: lineChartAxisYProp },
                AppFieldText{ id: lineChartAxisYStepProp; labelName: "step"; labelWidth: 100; txtFieldWidth: 60; spacing: 0  }
            ]
        }

        PropertiesSection{
            id: propsSectionLineChartGrid
            titleName: qsTr("Grid")
            properties:[
                FieldCheck{ id: lineChartGridCheckProp; labelName: "Enabled"; labelWidth: 100; font: Styles.fonts.caption },
                ColorProperty {id: lineChartGridColorProp }
            ]
        }

        PropertiesSection{
            id: propsSectionLineChartLegend
            titleName: qsTr("Legend")
            properties:[
                FieldCheck{ id: lineChartLegendCheckProp; labelName: "Enabled"; labelWidth: 100; font: Styles.fonts.caption },
                TextProperty{ id: lineChartLegendTextProp },
                AppComboBox {id: lineChartLegendMarkerShape },
                AppComboBox {id: lineChartLegendAlignment }
            ]
        }
*/

              }


          }

