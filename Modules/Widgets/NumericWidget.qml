import QtQuick 2.12
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.2

// needs to add due to Qt6.3 and Windows bug: root.pressed doesn't work on Windows
// import QtQuick.Controls.Basic

import AppStyles 1.0
import Components 1.0

DashboardWidget{
    id: root

    property real min: -1980.0
    property real max: 1980.0
    property real value: 50.0
    property real precision: 2

    property alias valueFont: valueTxt.font

    property alias titleText: titleTxt.text
    property alias titleColor: titleTxt.color
    property alias titleFont: titleTxt.font

    property string unit: "N"

    property color minColor: Styles.minColor
    property color midColor: Styles.midColor
    property color maxColor: Styles.maxColor

    property int _margins: 8

//    property int barWidth: 6
//    property int barMargin: 0
//    property color barColor: "gray"
//    property int originTickWidth: 4

    implicitWidth: rootCL.implicitWidth + 2*_margins; implicitHeight: rootCL.implicitHeight + 2*_margins

    minimumWidth:  rootCL.implicitWidth + 2*_margins
    minimumHeight: rootCL.implicitHeight + 2*_margins

//   onValueChanged: { barCanvas.requestPaint() }
//   Behavior on value{ NumberAnimation{ duration: 300 } }

    Timer{
        id: valueGenerator

        interval: 1000; running: true; repeat: true
        onTriggered: { value = Math.random() * (max - min) + min }
    }

    LinearGradientModel{
        id: linearGradient

        stopToColor: new Map([ [0, minColor], [50, midColor], [100, maxColor] ])
        min: root.min
        max: root.max
    }

    TextMetrics { id: valueTM; font: valueFont; text: "-1980.00" }
    TextMetrics { id: unitTM; font: valueFont; text: "N" }

    ColumnLayout{
        id: rootCL

        anchors{
            top: parent.top
            left: parent.left
            margins: root.background.radius >= 10 ? root.background.radius/2 : _margins
        }
        spacing: 10

        Text{
            id: titleTxt

            Layout.fillWidth: true
            text: "Fx"
            font: Styles.fonts.numericTitle
            color: Styles.foreground.high
        }

        RowLayout{
            id: valueUnitRL

            Layout.preferredHeight: valueTxt.implicitHeight

            Text{
                id: valueTxt

                Layout.preferredWidth: valueTM.advanceWidth
                text: value.toFixed(precision)
                font: Styles.fonts.numericValue
                color: linearGradient.getColor(value)
            }

            Text{
                id: unitTxt

                Layout.preferredWidth: unitTM.advanceWidth
                text: unit
                font: valueFont
                color: linearGradient.getColor(value)
            }
        }
    }

    /*
        Canvas{
            id: barBackgroundCanvas

            Layout.fillWidth: true; Layout.preferredHeight: barWidth

            onPaint:{
                var ctx = getContext("2d")
                ctx.lineWidth = barWidth
                ctx.strokeStyle = barColor

                ctx.beginPath()
                ctx.moveTo(0, barWidth/2)
                ctx.lineTo(width, barWidth/2)
                ctx.stroke()

                if(min*max < 0){
                    ctx.strokeStyle = "black"
                    const startPoint = barCanvas.calculateStartPoint()
                    ctx.beginPath()
                    ctx.moveTo(startPoint.x - originTickWidth/2, barWidth/2)
                    ctx.lineTo(startPoint.x + originTickWidth/2, barWidth/2)
                    ctx.stroke()
                }
            }

            Canvas{
                id: barCanvas

                function calculateStartPoint(){
                    return min*max < 0 ? Qt.point(width * Math.abs(min/(max - min)), height/2) : Qt.point(0, height/2)
                }

                function calculateEndPoint(){
                    return min*max < 0 ? value >= 0 ? Qt.point(width, height/2) : Qt.point(0, height/2) : Qt.point(width, height/2)
                }

                function calculateValuePoint(){
                    var maxWidth = width * Math.abs(max/(max - min))
                    var minWidth = width * Math.abs(min/(max - min))

                    var valueX = min*max < 0 ? value >= 0 ? value * width/Math.abs(max - min) : value * width/Math.abs(max - min)
                                             : (value - min) * width/Math.abs(max - min)

                    return Qt.point(valueX, height/2)
                }

                function calculateGradient(ctx, startPoint, endPoint){
                    var barGradient = ctx.createLinearGradient(startPoint.x, startPoint.y, endPoint.x, endPoint.y);
                    barGradient.addColorStop(0.0, minColor);
                    barGradient.addColorStop(0.5, midColor);
                    barGradient.addColorStop(1.0, maxColor);
                    return barGradient
                }

                anchors.fill: parent

                onPaint:{
                    var ctx = getContext("2d")
                    ctx.clearRect(0, 0, width, height)
                    ctx.lineWidth = barWidth - 2*barMargin
                    const startPoint = calculateStartPoint()
                    const endPoint = calculateEndPoint()
                    const valuePoint = calculateValuePoint()
                    ctx.strokeStyle = calculateGradient(ctx, startPoint, endPoint)

                    ctx.beginPath()
                    ctx.moveTo(startPoint.x, startPoint.y)
                    ctx.lineTo(startPoint.x + valuePoint.x, valuePoint.y)
                    ctx.stroke()
                }
            }
        }
*/
}
