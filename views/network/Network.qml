import QtQuick 2.12
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

import AppStyle 1.0
import Components 1.0

Rectangle{
    id: root

    color: "transparent"

    Rectangle{
        id: pane

        anchors{ fill: parent; topMargin: 1 }
        color: AppStyle.background

        ColumnLayout{
            id: rootCL

            anchors{
                fill: parent
                topMargin: 10
                leftMargin: 20
                rightMargin: 20
                bottomMargin: 10
            }
            spacing: 20

            Text{
                text: qsTr("Network")
                font: AppStyle.fonts.headline1
                color: AppStyle.foreground
                opacity: AppStyle.emphasis.high
            }

            NetworkTable{
                id: networkTable

                Layout.fillWidth: true; Layout.fillHeight: true
            }

        }
    }
}

