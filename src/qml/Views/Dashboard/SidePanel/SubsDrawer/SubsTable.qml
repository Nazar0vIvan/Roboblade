import QtQuick
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import Qt.labs.qmlmodels

import AppStyles 1.0
import Components 1.0

Item{
  id: root

  property alias model: tv.model

  ColumnLayout{
    id: rootCL

    anchors.fill: parent

    // --> Header
    HorizontalHeaderView{
      id: header

      syncView: tv
      delegate: DelegateChooser{

        // first header column
        DelegateChoice{
          id: firstHeaderColumnDC

          column: 0
          SubsTableCheckDelegate{

            required property bool selected

            implicitWidth: root.width/tv.model.columnCount(); implicitHeight: tv.rowHeight
            text: model.display
            overlayOpacity: 0.12

            onCheckedChanged: {
              const index = tv.model.index(row,0)
              ism.select(index, ItemSelectionModel.SelectCurrent | ItemSelectionModel.Rows)
            }
          }
        }
        // rest header
        DelegateChoice{
          id: restHeaderDc

          delegate: SubsTableItemDelegate{

            text: model.display
            font: Styles.fonts.subtitle
            overlayOpacity: 0.12
          }
        }
      }
    }
    // <-- Header

    // --> Table
    TableView{
      id: tv

      property int rowHeight: 30

      function updateSubsParms(subsParmsNames){
        let rowsNumbers = new Set([...Array(model.rowCount()).keys()])
        for(let parmName of subsParmsNames){
          for(let row of rowsNumbers){
            const index = model.index(row,0)
            if(model.data(index,0) === parmName){
              tv.highlightRow(index)
              rowsNumbers.delete(row)
            }
          }
        }
        firstHeaderColumnDC.children[0].checked = (subsParmsNames.size === model.rowCount())
      }

      signal requestSocketsInfo()

      Layout.fillWidth: true; Layout.fillHeight: true
      clip: true
      boundsBehavior: Flickable.StopAtBounds
      rowSpacing: 2

      // !! calling this function re-evaluates the size and position of each visible row and column
      // !! needed cause tableview loaded in stacklayout

      selectionModel: ItemSelectionModel{
        id: ism
        model: tv.model
      }

      delegate: DelegateChooser{
        // first column
        DelegateChoice{
          id: firstColumnDC

          column: 0
          SubsTableCheckDelegate{

            required property bool selected

            implicitWidth: root.width/tv.model.columnCount(); implicitHeight: tv.rowHeight
            text: model.display
            overlayOpacity: selected ? 0.07 : 0.0

            onCheckedChanged: {
              const index = tv.model.index(row,0)
              ism.select(index, ItemSelectionModel.Toggle | ItemSelectionModel.Rows)
            }
          }
        }
        // last column
        DelegateChoice{
          id: lastColumnDC

          column: tv.model.columnCount() - 1
          SubsTableItemDelegate{

            required property bool selected

            implicitWidth: root.width/tv.model.columnCount(); implicitHeight: tv.rowHeight
            text: model.display
            overlayOpacity: selected ? 0.07 : 0.0

            Rectangle{
              id: selectIndicator

              implicitWidth: 3; implicitHeight: parent.height
              anchors.right: parent.right
              color: Styles.secondary.base
              visible: parent.selected
            }
          }
        }
        // rest
        DelegateChoice{
          id: restDC

          SubsTableItemDelegate{

            required property bool selected

            implicitWidth: root.width/tv.model.columnCount(); implicitHeight: tv.rowHeight
            text: model.display
            overlayOpacity: selected ? 0.07 : 0.0
          }
        }
      }
    }
    // <-- Table

  }


}



/*
Item{
    id: root

    property var model
    property var widget

    property int _headerHeight: 34
    property int _columnWidth: width/model.columnCount()

    function updateModel(model){
        root.model = model
        updateSubsParms(widget.subs.get(root.model.id))
    }

    function updateSubsParms(subsParmsNames){
        tv.deselectAll()
        let rowsNumbers = new Set([...Array(model.rowCount()).keys()])
        for(let parmName of subsParmsNames){
            for(let row of rowsNumbers){
                const index = model.index(row,0)
                if(model.data(index,0) === parmName){
                    tv.highlightRow(index)
                    rowsNumbers.delete(row)
                }
            }
        }
        headerRepeater.itemAt(0).checked = (subsParmsNames.size === model.rowCount())
    }

    onWidgetChanged:{
        if (widget === null) return
        updateSubsParms(widget.subs.get(model.id))
    }

    ColumnLayout{
        id: rootCL

        anchors.fill: parent
        spacing: 5

        Rectangle{
            id: header

            Layout.fillWidth: true; Layout.preferredHeight: _headerHeight
            color: Styles.background

            Rectangle{
                id: overlay

                anchors.fill: parent
                color: Styles.foreground
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

                    SubsTableHeaderDelegate{
                        id: headerItem

                        height: _headerHeight; width: root._columnWidth
                        isExclusiveSelection: (widget !== null && (widget.type === 0 || widget.type === 1))
                        checkable: index === 0
                        text: root.model.headerData(index, Qt.Horizontal)

                        onClicked:{ if(index === 0) { if(tv.isAllSelected()) tv.deselectAll(); else tv.selectAll() } }
                    }
                }
            }
        }

        TableView {
            id: tv

            function isAllSelected(){
                return ism.isColumnSelected(0)
            }

            function highlightRow(index){
                ism.select(index, ItemSelectionModel.Select | ItemSelectionModel.Rows)
            }

            function selectRow(row){
                const index = model.index(row,0)
                ism.select(index, ItemSelectionModel.Select | ItemSelectionModel.Rows)
                widget.subs.get(model.id).add(model.data(index,0))
            }

            function deselectRow(row){
                const index = model.index(row,0)
                ism.select(index, ItemSelectionModel.Deselect | ItemSelectionModel.Rows)
                widget.subs.get(model.id).delete(model.data(index,0))
            }

            function selectAll(){
                for(var row = 0; row < model.rowCount(); ++row){
                    const index = model.index(row,0)
                    selectRow(row);
                    widget.subs.get(model.id).add(tv.model.data(index,0))
                }
            }

            function deselectAll(){
                ism.clear()
            }

            Layout.fillWidth: true; Layout.fillHeight: true
            rowSpacing: 2
            clip: true
            boundsBehavior: Flickable.StopAtBounds

            model: root.model
            selectionModel: ItemSelectionModel{
                id: ism
                model: root.model
            }

            delegate: SubsTableItemDelegate{ // row, column and index are available
                id: item

                required property bool selected

                implicitHeight: _headerHeight; implicitWidth: root._columnWidth
                isExclusiveSelection: (widget !== null && (widget.type === 0 || widget.type === 1))
                checkable: column === 0
                first: column === 0
                last: column === 4
                text: column === 0 ? Name :
                      column === 1 ? Type :
                      column === 2 ? Min :
                      column === 3 ? Max : Unit

                onClicked:{
                    const index = tv.model.index(row,0)
                    if(ism.isRowSelected(row)){
                        tv.deselectRow(row)
                    }
                    else if(widget.type === 0 || widget.type === 1){
                        tv.deselectAll()
                        for (let value of widget.subs.values()) value.clear()
                        tv.selectRow(row)
                    }
                    else{
                        tv.selectRow(row)
                    }
                    headerRepeater.itemAt(0).checked = tv.isAllSelected()
                }
            }
        }
    }
}
*/
