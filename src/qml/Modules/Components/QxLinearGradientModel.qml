pragma Singleton
import QtQuick 2.12

Item{
    id: root

    required property int min
    required property int max
    required property var stopToColor

    function _hexToRgb(hex) {
        var result = /^#?([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i.exec(hex);
        return result ? {
            r: parseInt(result[1], 16)/255,
            g: parseInt(result[2], 16)/255,
            b: parseInt(result[3], 16)/255
        } : null;
    }

    function _interpolate(startColor, endColor, percentage){
        return Qt.rgba(
                 startColor.r + percentage * (endColor.r - startColor.r),
                 startColor.g + percentage * (endColor.g - startColor.g),
                 startColor.b + percentage * (endColor.b - startColor.b),
                 1)
    }

    function _getRange(valueRatio){
        const keys = Array.from(stopToColor.keys());
        for(let i = 0; i < keys.length; ++i){
            if(100 * valueRatio < keys[i]){ return { start: keys[i-1], end: keys[i] } }
        }
    }

    function getColor(value){
        const valueRatio = min * max < 0 ? value >= 0 ? value/Math.abs(max) : Math.abs(value/min) : (value - min)/Math.abs(max - min)
        const range = _getRange(valueRatio)
        const percentage = (valueRatio * 100 - range.start)/(range.end - range.start)
        return _interpolate(stopToColor.get(range.start), stopToColor.get(range.end), percentage)
    }
}



