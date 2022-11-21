import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.15

// needs to add due to Qt6.3 and Windows bug: root.pressed doesn't work on Windows
import QtQuick.Controls.Basic

import AppStyle 1.0

Item{
    id: root

    property alias spacing: rootRL.spacing

    property int fieldWidth: 100
    property font font: txtField.font

    property alias text: txtField.text
    property alias fieldBackgroundColor: txtField.backgroundColor
    property alias fieldBorderWidth: txtField.borderWidth
    property alias fieldBorderRadius: txtField.borderRadius
    property alias fieldBorderColor: txtField.borderColor
    property alias fieldColor: txtField.color
    property alias fieldOpacity: txtField.opacity
    property alias validator: txtField.validator
    property alias readOnly: txtField.readOnly

    property alias defaultTxt: txtField.defaultTxt
    property alias defaultTxtColor: txtField.defaultTxtColor
    property alias defaultTxtOpacity: txtField.defaultTxtOpacity

    property int btnMargins: 4
    property int btnPadding: 3

    signal editingFinished()
    signal browsePressed()

    RowLayout{
        id: rootRL

        height: root.height

        AppTextField{
            id: txtField

            Layout.preferredWidth: fieldWidth - root.height
            Layout.preferredHeight: root.height

            onEditingFinished: root.editingFinished()
        }
        Button{
            id: btnBrowse

            Layout.preferredWidth:  root.height - btnMargins
            Layout.preferredHeight: root.height - btnMargins
            rightPadding: pressed ? btnPadding + 1 : btnPadding
            topPadding: pressed ? btnPadding + 1 : btnPadding
            padding: btnPadding      
            contentItem: Image{
                fillMode: Image.PreserveAspectFit
                source: "file:///" + applicationDirPath + "/icons/open.svg"
                mipmap: true
            }
            background: Rectangle{
                color: "transparent"
                radius: 4
                border{ width: btnBrowse.hovered ? 1 : 0; color: "gray" }

                Rectangle{
                    anchors.fill: parent
                    color: AppStyle.foreground
                    radius: parent.radius
                    opacity: btnBrowse.pressed ? AppStyle.overlays.pressed
                                               : btnBrowse.hovered ? AppStyle.overlays.hovered : 0
                }
            }
            onPressed: root.browsePressed()
        }
    }
}

