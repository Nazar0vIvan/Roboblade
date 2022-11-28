import QtQuick
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import Qt.labs.qmlmodels

import AppStyle 1.0
import Components 1.0
import Widgets 1.0

TableView{
    id: tv

    property int _rowHeight: 34
    property int _columnWidth: width/model.columnCount

    property int timeInterval: 1

    columnWidthProvider: function (column) { return tv.width/tv.model.columnCount }
    rowHeightProvider: function (row) { return _rowHeight }

    clip: true
    boundsBehavior: Flickable.StopAtBounds
    rowSpacing: 2

//    contentWidth: width
//    contentHeight: height

    onWidthChanged: forceLayout()

    selectionModel: ItemSelectionModel{
        id: ism
        model: tv.model
    }

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
            // header
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
    }


    delegate: DelegateChooser{

        // header
        DelegateChoice{
            id: headerDC

            row: 0
            ItemDelegate{

                required property bool selected

                implicitWidth: tv.columnWidthProvider(column); implicitHeight: tv.rowHeightProvider(row)

                contentItem: Text{
                    verticalAlignment: Text.AlignVCenter
                    text: model.display
                    color: AppStyle.foreground
                    font{family: "Roboto"; pixelSize: 14; bold: true }
                    opacity: AppStyle.emphasis.high
                }

                background: Rectangle{
                    color: AppStyle.foreground
                    opacity: 0.12
                }
            }
        }
        // row
        DelegateChoice{
            id: rowDC

            ItemDelegate{

                required property bool selected

                implicitWidth: tv.columnWidthProvider(column); implicitHeight: tv.rowHeightProvider(row)

                contentItem: Text{
                    verticalAlignment: Text.AlignVCenter
                    text: model.display
                    color: AppStyle.foreground
                    font: AppStyle.fonts.body
                    opacity: AppStyle.emphasis.high
                }

                background: Rectangle{
                    color: AppStyle.foreground
                    opacity: parent.selected ? 0.12 : 0.07
                }

                onClicked: {
                    console.log(row)
                    const index = tv.model.index(row,0)
                    ism.select(index, ItemSelectionModel.Select | ItemSelectionModel.Rows)
                }
            }
        }
    }

//    delegate: ItemDelegate{

//        required property bool selected

//        implicitWidth: tv.columnWidthProvider(column); implicitHeight: tv.rowHeightProvider(row)
//        leftPadding: 10

//        background: Rectangle{
//            color: AppStyle.foreground
//            opacity: 0.40
//        }

//        contentItem: Text{
//            verticalAlignment: Text.AlignVCenter
//            text: model.display
//            color: AppStyle.foreground
//            font{family: "Roboto"; pixelSize: 14; bold: true }
//            opacity: AppStyle.emphasis.high
//        }
//    }



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
