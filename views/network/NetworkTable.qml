import QtQuick 2.12
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtCharts 2.3

import AppStyle 1.0
import Components 1.0
import Widgets 1.0

Rectangle {
    id: root

    property int _labelWidth: 100
    property int _fieldWidth: 85
    property int _componentHeight: 30

    property var socket
    property int timeInterval: 1

    color: "transparent"

    ColumnLayout{
        id: rootCL

        anchors.fill: parent

        GridLayout{
            id: socketDataGL

            rows: 4; columns: 2
            columnSpacing: 25

            AppFormComponent{
                id: localAddressComp
                Layout.row: 0; Layout.column: 0
                Layout.preferredHeight: _componentHeight
                labelName: "Local Address"; labelWidth: _labelWidth
                field: AppTextField{
                    implicitWidth: _fieldWidth ; implicitHeight: _componentHeight
                    readOnly: true
                    text: socket.localAddress ? socket.localAddress : "N/D"
                }
            }
            AppFormComponent{
                id: localPortComp
                Layout.row: 1; Layout.column: 0
                Layout.preferredHeight: _componentHeight
                labelName: "Local Port"; labelWidth: _labelWidth
                field: AppTextField{
                    implicitWidth: _fieldWidth ; implicitHeight: _componentHeight
                    readOnly: true
                    text: socket.localPort ? socket.localPort : "N/D"
                }

            }
            AppFormComponent{
                id: peerAddressComp
                Layout.row: 2; Layout.column: 0
                Layout.preferredHeight: _componentHeight
                labelName: "Peer Address"; labelWidth: _labelWidth
                field: AppTextField{
                    implicitWidth: _fieldWidth ; implicitHeight: _componentHeight
                    readOnly: true
                    text: socket.peerAddress ? socket.peerAddress : "N/D"
                }
            }
            AppFormComponent{
                id: peerPortComp
                Layout.row: 3; Layout.column: 0
                Layout.preferredHeight: _componentHeight
                labelName: "Peer Port"; labelWidth: _labelWidth
                field: AppTextField{
                    implicitWidth: _fieldWidth ; implicitHeight: _componentHeight
                    readOnly: true
                    text: socket.peerPort ? socket.peerPort : "N/D"
                }
            }

            AppFormComponent{
                id: typeComp
                Layout.row: 0; Layout.column: 1
                Layout.preferredHeight: _componentHeight
                labelName: "Type"; labelWidth: _labelWidth
                field: AppTextField{
                    implicitWidth: _fieldWidth ; implicitHeight: _componentHeight
                    readOnly: true
                    text: socket.type ? socket.type : "N/D"
                }
            }
            AppFormComponent{
                id: statusComp
                Layout.row: 1; Layout.column: 1
                Layout.preferredHeight: _componentHeight
                labelName: "Status"; labelWidth: _labelWidth
                field: AppTextField{
                    implicitWidth: _fieldWidth ; implicitHeight: _componentHeight
                    readOnly: socket.stateToString() ? socket.stateToString() : "N/D"
                }
            }
            AppFormComponent{
                id: openMode
                Layout.row: 2; Layout.column: 1
                Layout.preferredHeight: _componentHeight
                labelName: "OpenMode"; labelWidth: _labelWidth
                field: AppTextField{
                    implicitWidth: _fieldWidth ; implicitHeight: _componentHeight
                    readOnly: true
                    text: socket.openMode ? socket.openMode : "N/D"
                }
            }
            AppFormComponent{
                id: timeIntervalComp
                Layout.row: 3; Layout.column: 1
                Layout.preferredHeight: _componentHeight
                labelName: "Time Interval"; labelWidth: _labelWidth
                field: AppTextField{
                    implicitWidth: _fieldWidth ; implicitHeight: _componentHeight
                    readOnly: true
                    text: root.timeInterval
                }
            }
        }

        ChartView{
            id: dtrChart // dtr - data transfer rate

            Layout.fillWidth: true; Layout.fillHeight: true
            Layout.leftMargin: -10
            backgroundColor: "transparent"

            antialiasing: true
            margins{ bottom: 5; top: 5; left: 0; right: 5 }
            legend.visible: false

            ValuesAxis{
                id: xAxis

                min: 0
                max: 5

                color: AppStyle.foreground

                gridLineColor: "gray"
                gridVisible: true

                labelsColor: AppStyle.foreground
                labelsFont: AppStyle.fonts.caption
                labelsVisible: true
            }

            ValuesAxis{
                id: yAxis

                min: 0
                max: 10

                color: AppStyle.foreground

                gridLineColor: "gray"
                gridVisible: true

                labelsColor: AppStyle.foreground
                labelsFont: AppStyle.fonts.caption
                labelsVisible: true
            }

            SplineSeries {
                id: series

                name: "SplineSeries"

                axisX: xAxis
                axisY: yAxis

                XYPoint{ x: 0;   y: 0.0 }
                XYPoint{ x: 1.1; y: 3.2 }
                XYPoint{ x: 1.9; y: 2.4 }
                XYPoint{ x: 2.1; y: 2.1 }
                XYPoint{ x: 2.9; y: 2.6 }
                XYPoint{ x: 3.4; y: 2.3 }
                XYPoint{ x: 4.1; y: 3.1 }

            }
        }
    }

}
