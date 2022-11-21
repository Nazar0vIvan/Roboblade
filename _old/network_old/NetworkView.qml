import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.2

import AppStyle 1.0

Rectangle{
    id: root

    readonly property int fieldHeight: 30

    color: AppStyle.background

    ColumnLayout{
        anchors.fill: parent
        anchors.margins: 10; anchors.topMargin: 20
        spacing: 10

        GroupBox{
            id: socketsGroupBox
            Layout.fillWidth: true; Layout.fillHeight: true
            Layout.alignment: Qt.AlignTop
            label: Rectangle{
                x: 10; y: -socketsTitle.font.pixelSize/2-5
                color: AppStyle.background
                width: socketsTitle.width + 10; height: socketsTitle.font.pixelSize + 10
                border{color: "#bdbdbd"; width: 1}

                Text{
                    id: socketsTitle
                    anchors.centerIn: parent
                    text: qsTr("SOCKETS")
                    color: AppStyle.foreground
                    font: AppStyle.fonts.body
                }
            }
            ColumnLayout{
                id: columnLayout
                anchors.fill: parent
                anchors.topMargin: 10
                spacing: 10

                SocketControls{
                    id: krcSocketControls

                    Layout.preferredWidth: 170
                    Layout.preferredHeight: topPadding + bottomPadding + 3*root.fieldHeight - 10 + 2*spacing
                    Layout.alignment: Qt.AlignTop
                    title: qsTr("KRC")
                    fieldHeight: root.fieldHeight
                    socket: socketRSI
                }
                SocketControls{
                    id: ftsSocketControls

                    Layout.preferredWidth: 170
                    Layout.preferredHeight: topPadding + bottomPadding + 3*root.fieldHeight - 10 + 2*spacing
                    Layout.alignment: Qt.AlignTop
                    title: qsTr("FTS")
                    fieldHeight: root.fieldHeight
                    socket: socketRDT
                }
                SocketControls{
                    id: houSocketControls

                    Layout.preferredWidth: 170
                    Layout.preferredHeight: topPadding + bottomPadding + 3*root.fieldHeight - 10 + 2*spacing
                    Layout.alignment: Qt.AlignTop
                    title: qsTr("Houdini")
                    fieldHeight: root.fieldHeight
                    socket: socketHou

                }
                Item{
                    Layout.fillHeight: true
                }

            }

        }
    }
}
