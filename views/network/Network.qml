import QtQuick 2.12
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtCharts 2.2

import AppStyle 1.0
import Components 1.0

Rectangle{
    id: root

    color: AppStyle.background

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
            font: AppStyle.fonts.headline1
            color: AppStyle.foreground
            opacity: AppStyle.emphasis.high
        }

        NetworkTable{
            id: networkTable

            Layout.fillWidth: true; Layout.fillHeight: true
        }
/*
        ChartView{
            id: dtrChart // dtr - data transfer rate

            Layout.fillWidth: true; Layout.fillHeight: true
            Layout.leftMargin: -10
            backgroundColor: "transparent"

            antialiasing: true
            margins{ bottom: 5; top: 5; left: 0; right: 5 }
            legend.visible: false

            ValuesAxis{
                id: xAxis

                min: 0
                max: 5

                color: AppStyle.foreground

                gridLineColor: "gray"
                gridVisible: true

                labelsColor: AppStyle.foreground
                labelsFont: AppStyle.fonts.caption
                labelsVisible: true
            }

            ValuesAxis{
                id: yAxis

                min: 0
                max: 10

                color: AppStyle.foreground

                gridLineColor: "gray"
                gridVisible: true

                labelsColor: AppStyle.foreground
                labelsFont: AppStyle.fonts.caption
                labelsVisible: true
            }

            SplineSeries {
                id: series

                name: "SplineSeries"

                axisX: xAxis
                axisY: yAxis

                XYPoint{ x: 0;   y: 0.0 }
                XYPoint{ x: 1.1; y: 3.2 }
                XYPoint{ x: 1.9; y: 2.4 }
                XYPoint{ x: 2.1; y: 2.1 }
                XYPoint{ x: 2.9; y: 2.6 }
                XYPoint{ x: 3.4; y: 2.3 }
                XYPoint{ x: 4.1; y: 3.1 }

            }
        }
*/
    }
}

