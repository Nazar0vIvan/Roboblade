import QtQuick 2.12
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.2
import QtCharts 2.3

import qml.Modules.Styles 1.0

DashboardWidget{
    id: root

    property alias chartView: chartView

    property var seriesData: [ {name: "Fx", min: -500,  max: 500 },
                               {name: "Fy", min: -500,  max: 500 },
                               {name: "Fz", min: -1980, max: 1980} ]

    property real min: -1980
    property real max: 1980

    property string title: "Forces"
    property font titleFont: Styles.fonts.chartTitle

    property font legendFont: Styles.fonts.chartLegend

    property string axisYTitle: "N"
    property font axisFont: Styles.fonts.chartAxisLabel

    implicitWidth: 400; implicitHeight: 400

    ChartView{
        id: chartView

        /* !!!!! */
        z: 4
        /* !!!!! */

        anchors.fill: parent

        title: root.title
        titleFont: root.titleFont
        titleColor: Styles.foreground.high

        backgroundColor: "transparent"
        backgroundRoundness: 5

        antialiasing: true

        margins{ bottom: 5; top: 5; left: 5; right: 5 }

        legend.font: root.legendFont
        legend.labelColor: Styles.foreground.high
        legend.visible: true

        Timer{
            id: valueGenerator

            property real currentTime: 0.0

            interval: 1000; running: true; repeat: true
            onTriggered:{
                root.seriesData.forEach(obj => {
                    const value = Math.random() * (max - min) + min
                    chartView.series(obj.name).append(currentTime, value)
                })
                currentTime += interval/1000
            }
        }

        ValuesAxis{
            id: xAxis

            min: 0
            max: 180

            color: Styles.foreground.high

            gridLineColor: "gray"
            gridVisible: true

            labelsFont: root.axisFont
            labelsColor: Styles.foreground.high
            labelsVisible: true
        }

        ValuesAxis{
            id: yAxis

            min: root.min
            max: root.max

            color: Styles.foreground.high

            gridLineColor: "gray"
            gridVisible: true

            titleText: root.axisYTitle
            titleFont: root.axisFont
            titleBrush: Styles.foreground.high

            labelsFont: root.axisFont
            labelsColor: Styles.foreground.high
            labelsVisible: true
        }

        Component.onCompleted: {
            root.seriesData.forEach(obj => {

                chartView.createSeries(ChartView.ChartView.SeriesTypeSpline, obj.name, xAxis, yAxis);
            })
        }

    }
}
