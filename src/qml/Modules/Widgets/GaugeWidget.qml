import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.2

// needs to add due to Qt6.3 and Windows bug: root.pressed doesn't work on Windows
// import QtQuick.Controls.Basic

import AppStyles 1.0
import Components 1.0

DashboardWidget{
    id: root

    property real min: -1980.0
    property real max: 1980.0
    property real value: -500.0
    property real precision: 1

    property alias valueFont: valueTxt.font

    property alias titleText: titleTxt.text
    property alias titleFont: titleTxt.font
    property alias titleColor: titleTxt.color

    property string unit: "N"

    property color minColor: Styles.minColor
    property color midColor: Styles.midColor
    property color maxColor: Styles.maxColor
    property real beta: 100.0 // gap angle at the bottom of gauge
    property real offset: height/4*(1 - Math.cos(beta/2 * Math.PI/180.0))
    property real span: 360.0 - beta

    property real barCX: width/2
    property real barCY: height/2 + offset/2
    property int barWidth: 6
    property int barBackgroundWidth: 6
    property real barRadius: width/2 - offset/2
    property color barColor: "#808080"

    function getStartAngle(){
        return min*max >= 0 ? 90.0 + beta/2 : 90.0 + beta/2 + (-min)*span/Math.abs(max - min)
    }

    function getDeltaAngle(){
        return min*max >= 0 ? (value - min) * span/Math.abs(max - min) : value * span/Math.abs(max - min)
    }

    function createGradient(ctx, startAngle, minStop, midStop, maxStop){
        // Returns a CanvasGradient object that represents a conical gradient that
        // interpolates colors !COUNTER-CLOCKWISE! around a center point (x, y) with
        // a start angle angle in units of radians, startAngle also goes !COUNTER-CLOCKWISE!
        var barGradient = ctx.createConicalGradient(width/2, height/2, 2*Math.PI - startAngle);
        barGradient.addColorStop(minStop, minColor);
        barGradient.addColorStop(midStop, midColor);
        barGradient.addColorStop(maxStop, maxColor);
        return barGradient
    }

    function getBarGradient(ctx, startAngle){
        var maxAngleRatioNegative = Math.abs(max*span/Math.abs(max - min)) / 360.0
        var maxAngleRatioPositive = span / 360.0
        var minAngleRatio = Math.abs(min*span/Math.abs(max - min)) / 360.0

        return min*max < 0 ? value >= 0 ? createGradient(ctx, startAngle - Math.PI/180.0, 1.0, 1-maxAngleRatioNegative/2, 1-maxAngleRatioNegative)
                                        : createGradient(ctx, startAngle + Math.PI/180.0, 0.0, minAngleRatio/2, minAngleRatio)
                           : createGradient(ctx, startAngle - Math.PI/180.0, 1.0, 1-maxAngleRatioPositive/2, 1-maxAngleRatioPositive)
    }

    implicitWidth: 180; implicitHeight: 180
    isSquare: true

    Timer {
        interval: 2000; running: true; repeat: true
        onTriggered: { value = Math.random() * (max - min) + min }
    }

    onValueChanged: { barCanvas.requestPaint() }

    LinearGradientModel{
        id: linearGradient

        stopToColor: new Map([ [0, minColor], [50, midColor], [100, maxColor] ])
        min: root.min
        max: root.max
    }

    Canvas{
        id: barBackgroundCanvas

        anchors{ fill: parent; }

        onPaint:{
            var ctx = getContext("2d")
            ctx.lineWidth = barBackgroundWidth
            ctx.strokeStyle = barColor
            ctx.beginPath()
            const startAngle = (90.0 + beta/2) * Math.PI/180.0
            const endAngle = startAngle + (360.0 - beta) * Math.PI/180.0

            ctx.arc(barCX, barCY, barRadius - ctx.lineWidth/2, startAngle, endAngle, false)
            ctx.stroke()
        }

        Canvas{
            id: barCanvas

            anchors.fill: parent

            onPaint:{
                var ctx = getContext("2d")
                ctx.clearRect(0, 0, width, height)
                ctx.lineWidth = barWidth
                const startAngle = getStartAngle() * Math.PI/180.0
                ctx.strokeStyle = getBarGradient(ctx, startAngle)

                ctx.beginPath()
                const deltaAngle = getDeltaAngle() * Math.PI/180.0
                const endAngle = startAngle + deltaAngle

                // don't effect on startAngle, startAngle always goes !CLOCKWISE!
                var anticlockwise = min*max >= 0 ? false : value >= 0 ? false : true
                ctx.arc(barCX, barCY, barRadius - ctx.lineWidth/2, startAngle, endAngle, anticlockwise)
                ctx.stroke()
            }
        }
    }

    ColumnLayout{
        id: rootCL

        x: root.width/2 - implicitWidth/2
        y: barCY - valueTxt.implicitHeight
        spacing: 0

        Text{
            id: valueTxt

            Layout.alignment: Qt.AlignHCenter
            text: value.toFixed(precision)
            font: Styles.fonts.gaugeValue
            color: linearGradient.getColor(value)
        }
        Text{
            id: unitTxt

            Layout.alignment: Qt.AlignHCenter
            text: unit
            font: Styles.fonts.gaugeValue
            color: linearGradient.getColor(value)
        }
    }

    Text{
        id: minTxt

        x: barRadius * (1 - Math.sin(beta/2 * Math.PI/180.0)) + offset/2 + implicitHeight/2
        y: barRadius * (1 + Math.cos(beta/2 * Math.PI/180.0)) + offset/2 + implicitHeight/2

        text: min.toFixed(precision)
        font: Styles.fonts.caption
        color: Styles.foreground.medium
    }

    Text{
        id: maxTxt

        x: barRadius * (1 + Math.sin(beta/2 * Math.PI/180.0)) + offset/2 - implicitWidth - implicitHeight/2
        y: barRadius * (1 + Math.cos(beta/2 * Math.PI/180.0)) + offset/2 + implicitHeight/2

        text: max.toFixed(precision)
        font: Styles.fonts.caption
        color: Styles.foreground.medium
    }

    Text{
        id: titleTxt


        anchors{ top: parent.top; left: parent.left; margins: 10 }
        text: "Fx"
        font: Styles.fonts.gaugeTitle
        color: Styles.foreground.high
    }
}
