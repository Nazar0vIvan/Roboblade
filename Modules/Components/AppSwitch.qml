import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.15

import AppStyle 1.0

Switch {
    id: control

    property int bgdWidth: 34
    property int bgdHeight: 12
    property color bgdCheckedColor: AppStyle.secondary.light
    property color bgdUncheckedColor: "gray"

    property int handleWidth: 20
    property int handleHeight: 20
    property color handleCheckedColor: AppStyle.secondary.base
    property color handleUncheckedColor: AppStyle.foreground

    signal editingFinished()

    implicitWidth: childrenRect.width

    indicator: Rectangle {
        implicitWidth: bgdWidth; implicitHeight: bgdHeight
        anchors.verticalCenter: parent.verticalCenter
        radius: implicitHeight/2
        color: control.checked ? bgdCheckedColor : bgdUncheckedColor

        Behavior on color { ColorAnimation { duration:  200 } }

        Rectangle {
            x: control.checked ? parent.width - width : 0
            anchors.verticalCenter: parent.verticalCenter
            width: handleWidth; height: handleHeight
            radius: height/2
            color: control.checked ? handleCheckedColor : handleUncheckedColor

            Behavior on x { NumberAnimation { duration:  200 } }
            Behavior on color { ColorAnimation { duration:  200 } }
        }
    }
}

