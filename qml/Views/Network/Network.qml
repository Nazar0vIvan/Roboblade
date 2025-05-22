import QtQuick 2.12
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtCharts 2.2

import AppStyles 1.0
import Components 1.0

Item{
  id: root

  Rectangle{
    id: pane

    anchors{ fill: parent; topMargin: 2 }
    color: Styles.background.dp00

    ColumnLayout{
      id: rootCL

      anchors{
        fill: parent
        topMargin: 10
        leftMargin: 20
        rightMargin: 20
        bottomMargin: 10
      }
      spacing: 20

      Text{
        id: title

        text: qsTr("Network")
        font: Styles.fonts.headline1
        color: Styles.foreground.high
      }

      SplitView{
        id: splitView

        Layout.fillWidth: true; Layout.fillHeight: true
        orientation: Qt.Vertical

        handle: Rectangle {
          implicitHeight: 2
          color: SplitHandle.pressed | SplitHandle.hovered ? Styles.foreground.high : "gray"
        }

        NetworkTable{
          id: networkTable

          SplitView.fillWidth: true; SplitView.preferredHeight: SplitView.minimumHeight + 5
          SplitView.minimumHeight: (rowHeight + rowSpacing) * model.rowCount
        }

        ChartView{
          id: dtrChart // dtr - data transfer rate

          SplitView.fillWidth: true; SplitView.fillHeight: true

          backgroundColor: "transparent"
          antialiasing: true
          margins{ bottom: 5; top: 5; left: 0; right: 5 }
          legend.visible: false

          ValuesAxis{
            id: xAxis

            min: 0
            max: 60

            color: Styles.foreground.high

            gridLineColor: "gray"
            gridVisible: true

            labelsColor: Styles.foreground.high
            labelsFont: Styles.fonts.caption
            labelsVisible: true
          }

          ValuesAxis{
            id: yAxis

            min: 0
            max: 100

            color: Styles.foreground.high

            gridLineColor: "gray"
            gridVisible: true

            labelsColor: Styles.foreground.high
            labelsFont: Styles.fonts.caption
            labelsVisible: true
          }

          LineSeries {
            id: series

            name: "Line Series"

            axisX: xAxis
            axisY: yAxis

            XYPoint{ x: 0;   y: 0 }
            XYPoint{ x: 2;   y: 99 }

            XYPoint{ x: 10;  y: 99 }
            XYPoint{ x: 15;  y: 99 }
            XYPoint{ x: 20;  y: 99 }
            XYPoint{ x: 25;  y: 99 }
            XYPoint{ x: 30;  y: 99 }
            XYPoint{ x: 35;  y: 99 }
            XYPoint{ x: 40;  y: 99 }
            XYPoint{ x: 45;  y: 99 }
            XYPoint{ x: 50;  y: 99 }
            XYPoint{ x: 55;  y: 99 }
            XYPoint{ x: 60;  y: 99 }
            XYPoint{ x: 65;  y: 99 }
            XYPoint{ x: 70;  y: 99 }
            XYPoint{ x: 75;  y: 99 }
            XYPoint{ x: 80;  y: 99 }
            XYPoint{ x: 85;  y: 99 }
            XYPoint{ x: 90;  y: 99 }
            XYPoint{ x: 95;  y: 99 }
            XYPoint{ x: 100; y: 99 }



          }
        }
      }
    }
  }
}



