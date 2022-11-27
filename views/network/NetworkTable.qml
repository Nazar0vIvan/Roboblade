import QtQuick 2.12
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
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

    TableView{
        id: tv

        anchors.fill: parent
        clip: true

        model: TableModel{

            TableModelColumn{ display: "host" }
            TableModelColumn{ display: "localAddress" }
            TableModelColumn{ display: "localPort" }
            TableModelColumn{ display: "peerAddress" }
            TableModelColumn{ display: "peerPort" }
            TableModelColumn{ display: "protocol" }
            TableModelColumn{ display: "status" }
            TableModelColumn{ display: "openMode" }

            rows:[
                {
                    host: "Host",
                    localAddress: "Local Address",
                    localPort: "Local Port",
                    peerAddress: "Peer Address",
                    peerPort: "Peer Port",
                    protocol: "Protocol",
                    status: "Status",
                    openMode: "Open Mode"
                },

                // rdt
                {
                    host: "F/T Sensor",
                    localAddress: "192.168.1.1",
                    localPort: "59152",
                    peerAddress: "192.168.1.2",
                    peerPort: "49152",
                    protocol: "RDT",
                    status: "CLOSE",
                    openMode: "ReadOnly"
                }
            ]

            Component.onCompleted: {

            }
        }

        delegate: DelegateChooser {
            DelegateChoice {
                row: 0
                delegate: Text {
                    text: model.display
                    color: AppStyle.foreground
                }
            }
            DelegateChoice{
                delegate: Text {
                    text: model.display
                    color: AppStyle.foreground
                }
            }
        }

    }
}

//    // rdt
//    {
//        hostName: "F/T Sensor",
//        localPort: socketRDT.localPort ? socketRDT.localPort : "N/D",
//        localAddress: socketRDT.localAddress ? socketRDT.localAddress : "N/D",
//        peerPort: socketRDT.peerPort ? socketRDT.peerPort : "N/D",
//        peerAddress: socketRDT.peerAddress ? socketRDT.peerAddress : "N/D",
//        protocol: "RDT",
//        status: socketRDT.openMode ? "OPEN" : "CLOSE",
//        openMode: "R/W"
//    },
//    // hou
//    {
//        hostName: "Houdini",
//        localPort: socketRDT.localPort ? socketRDT.localPort : "N/D",
//        localAddress: socketRDT.localAddress ? socketRDT.localAddress : "N/D",
//        peerPort: socketRDT.peerPort ? socketRDT.peerPort : "N/D",
//        peerAddress: socketRDT.peerAddress ? socketRDT.peerAddress : "N/D",
//        protocol: "UDP/IP",
//        status: socketRDT.openMode ? "OPEN" : "CLOSE",
//        openMode: "R/W"

//    },
//    // vfd/A65
//    {
//        hostName: "VFD/A65",
//        localPort: socketRDT.localPort ? socketRDT.localPort : "N/D",
//        localAddress: socketRDT.localAddress ? socketRDT.localAddress : "N/D",
//        peerPort: socketRDT.peerPort ? socketRDT.peerPort : "N/D",
//        peerAddress: socketRDT.peerAddress ? socketRDT.peerAddress : "N/D",
//        protocol: "RDT",
//        status: socketRDT.openMode ? "OPEN" : "CLOSE",
//        openMode: "R/W"

//    }
