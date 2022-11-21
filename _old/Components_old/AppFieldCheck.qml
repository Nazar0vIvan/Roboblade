import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.15

import AppStyle 1.0

Item {
    id: root

    property font fieldFont: AppStyle.fonts.body
    property alias spacing: rootRL.spacing

    property string labelName
    property alias labelBgd: label.background
    property int labelWidth: 100
    property color labelColor: AppStyle.foreground
    property string labelOpacity: AppStyle.elevation.high

    property int bgdWidth: 34
    property int bgdHeight: 12
    property color bgdCheckedColor: AppStyle.secondary.light
    property color bgdUncheckedColor: "gray"

    property int handleWidth: 20
    property int handleHeight: 20
    property color handleCheckedColor: AppStyle.secondary.base
    property color handleUncheckedColor: AppStyle.foreground

    implicitWidth: childrenRect.width

    RowLayout{
        id: rootRL

        height: root.height

        Label{
            id: label

            Layout.preferredWidth: Math.max(root.labelWidth,label.implicitWidth)
            Layout.preferredHeight: root.height
            Layout.alignment: Qt.AlignLeft
            verticalAlignment: Text.AlignVCenter
            text: labelName
            font: fieldFont
            color: labelColor
            opacity: labelOpacity
            background: Rectangle{color: "yellow"}
        }

        Switch {
            id: swt

            indicator: Rectangle {
                implicitWidth: bgdWidth; implicitHeight: bgdHeight
                anchors.verticalCenter: parent.verticalCenter
                radius: implicitHeight/2
                color: swt.checked ? bgdCheckedColor : bgdUncheckedColor

                Behavior on color { ColorAnimation { duration:  200 } }

                Rectangle {
                    x: swt.checked ? parent.width - width : 0
                    anchors.verticalCenter: parent.verticalCenter
                    width: handleWidth; height: handleHeight
                    radius: height/2
                    color: swt.checked ? handleCheckedColor : handleUncheckedColor

                    Behavior on x { NumberAnimation { duration:  200 } }
                    Behavior on color { ColorAnimation { duration:  200 } }
                }
            }
        }
    }
}
