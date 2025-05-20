import QtQuick
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import Qt.labs.qmlmodels

import AppStyles 1.0
import Components 1.0
import Widgets 1.0

TableView{
  id: tv

  property int rowHeight: 30

  signal requestSocketsInfo()

  columnWidthProvider: function (column) { return tv.width/tv.model.columnCount }
  rowHeightProvider: function (row) { return rowHeight }

  clip: true
  boundsBehavior: Flickable.StopAtBounds
  rowSpacing: 2

  // !! calling this function re-evaluates the size and position of each visible row and column
  // !! needed cause tableview loaded in stacklayout
  onWidthChanged: forceLayout()

  selectionModel: ItemSelectionModel{
    id: ism
    model: tv.model
  }

  model: TableModel{

    function slotUpdateUI(socketID, hostName, localAddress, localPort, peerAddress, peerPort, protocol, status, openMode){
      var row = socketID
      setRow(row, {
               hostName: hostName,
               localAddress: localAddress ? localAddress : "N/D",
               localPort: localPort ? localPort : "N/D",
               peerAddress: peerAddress ? peerAddress : "N/D",
               peerPort: peerPort ? peerPort : "N/D",
               protocol: protocol,
               status: status ? "OPEN" : "CLOSED",
               openMode: openMode === 1 ? "R" : openMode === 3 ? "R/W" : "NOT OPEN"
             })
    }

    TableModelColumn{ display: "hostName" }
    TableModelColumn{ display: "localAddress" }
    TableModelColumn{ display: "localPort" }
    TableModelColumn{ display: "peerAddress" }
    TableModelColumn{ display: "peerPort" }
    TableModelColumn{ display: "protocol" }
    TableModelColumn{ display: "status" }
    TableModelColumn{ display: "openMode" }

    rows:[
      {
        hostName: "Host",
        localAddress: "Local Address",
        localPort: "Local Port",
        peerAddress: "Peer Address",
        peerPort: "Peer Port",
        protocol: "Protocol",
        status: "Status",
        openMode: "Open Mode"
      },
    ]

    Component.onCompleted:{

      requestSocketsInfo.connect(socketRSI.slotRequestSocketInfo)
      requestSocketsInfo.connect(socketRDT.slotRequestSocketInfo)
      requestSocketsInfo.connect(socketHou.slotRequestSocketInfo)
      requestSocketsInfo.connect(socketVFDA65.slotRequestSocketInfo)

      socketRSI.sendSocketInfo.connect(slotUpdateUI)
      socketRDT.sendSocketInfo.connect(slotUpdateUI)
      socketHou.sendSocketInfo.connect(slotUpdateUI)
      socketVFDA65.sendSocketInfo.connect(slotUpdateUI)

      // initialize model
      requestSocketsInfo()
    }
  }

  delegate: DelegateChooser{

    // header
    DelegateChoice{
      id: headerDC

      row: 0
      NetworkTableItemDelegate{
        implicitWidth: tv.columnWidthProvider(column); implicitHeight: tv.rowHeightProvider(row)
        text: model.display
        font{ family: "Roboto"; pixelSize: 14; bold: true }
        overlayOpacity: 0.2
      }
    }
    // last column
    DelegateChoice{
      id: lastColumnDC

      column: model.columnCount - 1
      NetworkTableItemDelegate{

        required property bool selected

        implicitWidth: tv.columnWidthProvider(column); implicitHeight: tv.rowHeightProvider(row)
        text: model.display
        font: Styles.fonts.body
        overlayOpacity: selected ? 0.12 : 0.07

        onClicked: {
          const index = tv.model.index(row,0)
          ism.select(index, ItemSelectionModel.SelectCurrent | ItemSelectionModel.Rows)
        }

        Rectangle{
          id: selectIndicator

          anchors.right: parent.right
          implicitWidth: 3; implicitHeight: parent.height
          color: Styles.secondary.base
          visible: parent.selected
        }
      }
    }
    // status column
    DelegateChoice{
      id: statusDC

      column: 6
      NetworkTableItemDelegate{

        required property bool selected

        implicitWidth: tv.columnWidthProvider(column); implicitHeight: tv.rowHeightProvider(row)
        text: model.display
        font: Styles.fonts.body
        color: text === "OPEN" ? Styles.minColor : Styles.maxColor
        overlayOpacity: selected ? 0.12 : 0.07

        onClicked:{
          const index = tv.model.index(row,0)
          ism.select(index, ItemSelectionModel.SelectCurrent | ItemSelectionModel.Rows)
        }
      }
    }
    // rest
    DelegateChoice{
      id: restDC

      NetworkTableItemDelegate{

        required property bool selected

        implicitWidth: tv.columnWidthProvider(column); implicitHeight: tv.rowHeightProvider(row)
        text: model.display
        font: Styles.fonts.body
        overlayOpacity: selected ? 0.12 : 0.07

        onClicked: {
          const index = tv.model.index(row,0)
          ism.select(index, ItemSelectionModel.SelectCurrent | ItemSelectionModel.Rows)
        }
      }
    }
  }
}


