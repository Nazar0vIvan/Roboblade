import QtQuick 2.12
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtCharts 2.3
import Qt.labs.qmlmodels

import AppStyle 1.0
import Components 1.0
import Widgets 1.0

Item{
    id: root


    property int _columnWidth: width/tv.model.columnCount
    property int _headerHeight: 34

    property var socket
    property int timeInterval: 1

    ColumnLayout{
        id: rootCL

        anchors.fill: parent

        Rectangle{
            id: header

            Layout.fillWidth: true; Layout.preferredHeight: _headerHeight
            color: AppStyle.background

            Rectangle{
                id: overlay

                anchors.fill: parent
                color: AppStyle.foreground
                opacity: 0.10
            }

            Row{
                id: headerRow

                anchors.fill: parent
                spacing: 0

                Repeater{
                    id: headerRepeater

                    anchors.fill: parent
                    model: root.model.columnCount()

//                    SubsTableHeaderDelegate{
//                        id: headerItem

//                        height: _headerHeight; width: root._columnWidth
//                        isExclusiveSelection: (widget !== null && (widget.type === 0 || widget.type === 1))
//                        checkable: index === 0
//                        text: root.model.headerData(index, Qt.Horizontal)

//                        onClicked:{ if(index === 0) { if(tv.isAllSelected()) tv.deselectAll(); else tv.selectAll() } }
//                    }
                }
            }
        }

        TableView{
            id: tv

            model: TableModel{

                TableModelColumn{ display: "Host" }
                TableModelColumn{ display: "Local Port" }
                TableModelColumn{ display: "Local Address" }
                TableModelColumn{ display: "Peer Port" }
                TableModelColumn{ display: "Peer Address" }
                TableModelColumn{ display: "Protocol" }
                TableModelColumn{ display: "Status" }
                TableModelColumn{ display: "Open Mode" }

                rows:[
                    // rsi
                    {
                        hostName: "KR C4",
                        localPort: socketRSI.localPort ? socketRSI.localPort : "N/D",
                        localAddress: "192.168.1.1",
                        peerPort: socketRSI.peerPort ? socketRSI.peerPort : "N/D",
                        peerAddress: "192.168.1.2",
                        protocol: "RSI",
                        status: socketRSI.openMode ? "OPEN" : "CLOSE",
                        openMode: socketRSI.openMode === 1 ? "R" : socketRSI.openMode === 2 ? "W" : "R/W"
                    }
//                    // rdt
//                    {
//                        hostName: "F/T Sensor",
//                        localPort: socketRDT.localPort ? socketRDT.localPort : "N/D",
//                        localAddress: socketRDT.localAddress ? socketRDT.localAddress : "N/D",
//                        peerPort: socketRDT.peerPort ? socketRDT.peerPort : "N/D",
//                        peerAddress: socketRDT.peerAddress ? socketRDT.peerAddress : "N/D",
//                        protocol: "RDT",
//                        status: socketRDT.openMode ? "OPEN" : "CLOSE",
//                        openMode: "R/W"
//                    },
//                    // hou
//                    {
//                        hostName: "Houdini",
//                        localPort: socketRDT.localPort ? socketRDT.localPort : "N/D",
//                        localAddress: socketRDT.localAddress ? socketRDT.localAddress : "N/D",
//                        peerPort: socketRDT.peerPort ? socketRDT.peerPort : "N/D",
//                        peerAddress: socketRDT.peerAddress ? socketRDT.peerAddress : "N/D",
//                        protocol: "UDP/IP",
//                        status: socketRDT.openMode ? "OPEN" : "CLOSE",
//                        openMode: "R/W"

//                    },
//                    // vfd/A65
//                    {
//                        hostName: "VFD/A65",
//                        localPort: socketRDT.localPort ? socketRDT.localPort : "N/D",
//                        localAddress: socketRDT.localAddress ? socketRDT.localAddress : "N/D",
//                        peerPort: socketRDT.peerPort ? socketRDT.peerPort : "N/D",
//                        peerAddress: socketRDT.peerAddress ? socketRDT.peerAddress : "N/D",
//                        protocol: "RDT",
//                        status: socketRDT.openMode ? "OPEN" : "CLOSE",
//                        openMode: "R/W"

//                    }
                ]
            }
        }
    }
}
