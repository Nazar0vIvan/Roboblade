import QtQuick 2.12
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.2

import AppStyle 1.0

Item {
    id: root

    Rectangle{
        anchors.fill: parent
        color: AppStyle.background

        ColumnLayout{
            anchors.fill: parent
            Label{
                text: "Log"
                Layout.fillWidth: true; Layout.preferredHeight: 30
                leftPadding: 10
                color: AppStyle.foreground
                opacity: AppStyle.emphasis.high
                font: AppStyle.fonts.body
                background: Rectangle{ color: AppStyle.surface; opacity: AppStyle.emphasis.medium }
                verticalAlignment: Text.AlignVCenter
            }
            TextArea{
                id: textArea

                Layout.fillWidth: true; Layout.fillHeight: true
                color: AppStyle.foreground
                readOnly: true
                selectByMouse: true
                selectionColor: AppStyle.primary.transparent
                font: AppStyle.fonts.log
                background: Rectangle{ color: AppStyle.background }
            }
            Connections{
                target: logger
                function onLogAdded(message){ textArea.append(message) }
            }
        }
    }
}
