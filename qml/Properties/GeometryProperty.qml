import QtQuick 2.12
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.2

import AppStyles 1.0
import Components 1.0

Item{
    id: root

//    property alias repeater: geoPropertyRepeater

    property var wgt

    readonly property int _spacing: 0
    readonly property font _font: Styles.fonts.caption
    readonly property int _componentHeight: 25
    readonly property int _labelWidth: 20
    readonly property int _fieldWidth: 50

    function setWidget(wgt){ root.wgt = wgt }
    function setX(){ wgt.x = parseInt(xProp.field.text) }
    function setY(){ wgt.y = parseInt(yProp.field.text) }
    function setW(){ wgt.width = parseInt(wProp.field.text)  }
    function setH(){ wgt.height = parseInt(hProp.field.text) }

    function removeBindingsAndSignals(){
        xProp.field.text = null
        yProp.field.text = null
        wProp.field.text = null
        hProp.field.text = null

        xProp.editingFinished.disconnect(setX)
        yProp.editingFinished.disconnect(setY)
        wProp.editingFinished.disconnect(setW)
        hProp.editingFinished.disconnect(setH)
    }

    function setBindingsAndSignals(){
        xProp.field.text = Qt.binding(function(){ return Math.round(wgt.x) })
        yProp.field.text = Qt.binding(function(){ return Math.round(wgt.y) })
        wProp.field.text = Qt.binding(function(){ return Math.round(wgt.width) })
        hProp.field.text = Qt.binding(function(){ return Math.round(wgt.height) })

        xProp.editingFinished.connect(setX)
        yProp.editingFinished.connect(setY)
        wProp.editingFinished.connect(setW)
        hProp.editingFinished.connect(setH)
    }

    implicitHeight: childrenRect.height

    onWgtChanged:{ if(wgt !== null) setBindingsAndSignals(); else removeBindingsAndSignals() }

    GridLayout{
        id: rootGL

        rows: 2; columns: 2
        rowSpacing: 0; columnSpacing: 8

        /*
        Repeater{
            id: geoPropertyRepeater

            model: ['X', 'Y', 'W', 'Y']

            AppTextField{

                required property string modelData

                Layout.preferredWidth: 80; Layout.preferredHeight: 30
                spacing: 10
                labelName: modelData
                labelWidth: 20
                fieldWidth: 50
                txtFieldLeftPadding: 0
            }
        }
        */

        AppFormComponent{
            id: xProp

            Layout.preferredHeight: _componentHeight
            spacing: _spacing
            labelWidth: _labelWidth
            labelName: "X"
            font: Styles.fonts.caption
            field: AppTextField{
                width: _fieldWidth; height: _componentHeight
                backgroundColor: "transparent"
                validator: IntValidator{ bottom: 0 }
                font: Styles.fonts.caption
            }
        }

        AppFormComponent{
            id: yProp

            Layout.preferredHeight: _componentHeight
            spacing: _spacing
            labelWidth: _labelWidth
            labelName: "Y"
            font: Styles.fonts.caption
            field: AppTextField{
                width: _fieldWidth; height: _componentHeight
                backgroundColor: "transparent"
                validator: IntValidator{ bottom: 0 }
                font: Styles.fonts.caption
            }
        }

        AppFormComponent{
            id: wProp

            Layout.preferredHeight: _componentHeight
            spacing: _spacing
            labelWidth: _labelWidth
            labelName: "W"
            font: Styles.fonts.caption
            field: AppTextField{
                width: _fieldWidth; height: _componentHeight
                backgroundColor: "transparent"
                validator: IntValidator{ bottom: 0 }
                font: Styles.fonts.caption
            }
        }

        AppFormComponent{
            id: hProp

            Layout.preferredHeight: _componentHeight
            spacing: _spacing
            labelWidth: _labelWidth
            labelName: "H"
            font: Styles.fonts.caption
            field: AppTextField{
                width: _fieldWidth; height: _componentHeight
                backgroundColor: "transparent"
                validator: IntValidator{ bottom: 0 }
                font: Styles.fonts.caption
            }
        }
    }
}
