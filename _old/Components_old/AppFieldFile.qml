import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.15

// needs to add due to Qt6.3 and Windows bug: root.pressed doesn't work on Windows
import QtQuick.Controls.Basic

import AppStyle 1.0

Item{
    id: root

    property font fieldFont: AppStyle.fonts.body
    property alias spacing: rootRL.spacing
    property alias rightSpacing: rightRL.spacing

    property string labelName
    property alias labelBgd: label.background
    property int labelWidth: 100
    property color labelColor: AppStyle.foreground
    property string labelOpacity: AppStyle.elevation.high

    property int txtFieldWidth: 100
    property color txtFieldBgdColor: "transparent"
    property int txtFieldBorderWidth: 1
    property int txtFieldBorderRadius: 4
    property color txtFieldBorderColor: "gray"
    property alias text: txtField.text
    property color txtFieldColor: AppStyle.foreground
    property real txtFieldOpacity: AppStyle.elevation.high
    property color txtSelectionColor: AppStyle.highlight
    property alias validator: txtField.validator
    property alias readOnly: txtField.readOnly

    property alias defaultTxt: defaultTxt.text
    property color defaultTxtColor: AppStyle.foreground
    property real defaultTxtOpacity: AppStyle.elevation.disabled

    property int btnMargins: 4
    property int btnPadding: 2

    signal editingFinished()
    signal browsePressed()

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
        }

        RowLayout{
            id: rightRL

            Layout.preferredHeight: root.height

            TextField{
                id: txtField

                Layout.preferredWidth: txtFieldWidth
                Layout.preferredHeight: root.height
                verticalAlignment: Text.AlignVCenter
                leftPadding: 5
                font: fieldFont
                color: txtFieldColor
                opacity: txtFieldOpacity
                selectionColor: txtSelectionColor
                selectByMouse: true

                background: Rectangle{
                    color: txtFieldBgdColor
                    radius: txtFieldBorderRadius
                    border{
                        width: txtField.activeFocus ? 2 : !txtFieldBorderWidth ? txtField.hovered ? txtFieldBorderWidth : 0 : txtFieldBorderWidth
                        color: txtField.activeFocus ? AppStyle.primary.base : txtFieldBorderColor
                    }
                }
                onEditingFinished: root.editingFinished()

                Text{
                    id: defaultTxt

                    anchors.fill: parent
                    verticalAlignment: Text.AlignVCenter
                    leftPadding: 5
                    color: defaultTxtColor
                    opacity: defaultTxtOpacity
                    visible: !txtField.text
                    font.italic: true
                }
            }

            Button{
                id: btnBrowse

                Layout.preferredWidth:  root.height - btnMargins
                Layout.preferredHeight: root.height - btnMargins
                padding: btnPadding
                background: Rectangle{
                    color: btnBrowse.pressed ? AppStyle.surface : btnBrowse.hovered ? AppStyle.background : AppStyle.surface
                    border{ width: 1; color: "gray" }
                    radius: 4
                }
                contentItem: Image{
                    verticalAlignment: Image.AlignVCenter; horizontalAlignment: Image.AlignHCenter
                    fillMode: Image.PreserveAspectFit
                    source: "file:///" + applicationDirPath + "/icons/browse.svg"
                    mipmap: true
                }
                onPressed: root.browsePressed()
            }
        }
    }
}

