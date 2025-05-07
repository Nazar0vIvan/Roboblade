import QtQuick 2.12
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.2

import AppStyles 1.0
import Components 1.0

Item {
    id: root

    readonly property int _spacing: 0
    readonly property font _font: Styles.fonts.caption
    readonly property int _componentHeight: 25
    readonly property int _labelWidth: 20
    readonly property int _fieldWidth: 50
    readonly property int _padding: 8

    function setRadius(radius){ radiusField.text = radius }
    function setLineWidth(lineWidth){ lineWidthField.text = lineWidth }

    function getRadius(){ return parseInt(radiusField.text) }
    function getLineWidth(){ return parseInt(lineWidthField.text) }

    signal radiusEditingFinished()
    signal lineWidthEditingFinished()

    implicitWidth: parent.width; implicitHeight: root.childrenRect.height

    RowLayout{
        id: rootRL

        height: _componentHeight;

        AppFormComponent{
            id: radiusFormComponent

            Layout.preferredHeight: _componentHeight
            spacing: _spacing
            font: _font
            labelWidth: _labelWidth
            labelBackground: Image{
                anchors.centerIn: parent
                width: parent.width - _padding; height: parent.height - _padding
                source: "/dashboard/radius.svg"
                fillMode: Image.PreserveAspectFit
                mipmap: true
            }
            field: AppTextField{
                id: radiusField

                width: _fieldWidth; height: _componentHeight
                color: "transparent"
                font: Styles.fonts.caption
                validator: IntValidator{ bottom: 0 }

                onEditingFinished: root.radiusEditingFinished() // !!!
            }
        }

        AppFormComponent{
            id: lineWidthFormComponent

            Layout.preferredHeight: _componentHeight
            spacing: _spacing
            font: _font
            labelWidth: _labelWidth
            labelBackground: Image{
                anchors.centerIn: parent
                width: parent.width - _padding; height: parent.height - _padding
                source: "/dashboard/line_width.svg"
                fillMode: Image.PreserveAspectFit
                mipmap: true
            }
            field: AppTextField{
                id: lineWidthField

                width: _fieldWidth; height: _componentHeight
                color: "transparent"
                font: Styles.fonts.caption
                validator: IntValidator{ bottom: 0 }

                onEditingFinished: { root.lineWidthEditingFinished() } // !!!
            }
        }
    }

}
