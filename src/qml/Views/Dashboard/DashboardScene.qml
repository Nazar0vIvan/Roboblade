import QtQuick 2.15
import QtQuick.Controls 2.15

import qml.Modules.Styles 1.0
import qml.Modules.Components 1.0
import qml.Modules.Widgets 1.0

Rectangle{
  id: root

  signal selectionChanged(var wgt)

  function slotGrid(){ flick.isGrid = !flick.isGrid; flick.adjustWidgetsPositionsToGrid() }
  function slotSnap(){ flick.isSnap  = !flick.isSnap }

  function slotGridStepChanged(step)      { flick.gridStep = step; gridCanvas.requestPaint() }
  function slotGridLineTypeChanged(type)  { flick.gridLineType = type; gridCanvas.requestPaint() }
  function slotGridLineColorChanged(color){ flick.gridLineColor = color; gridCanvas.requestPaint() }
  function slotGridWidthChanged(width)    { flick.gridLineWidth = width; gridCanvas.requestPaint() }
  function slotGridOpacityChanged(opacity){ flick.gridOpacity = opacity/100; gridCanvas.requestPaint() }
  function slotSnapSpacingChanged(spacing){ flick.snapSpacing = spacing }

  Flickable{
    id: flick

    property var widgets: new Set()
    property var selectedWidget: null // may be either just single wgt or wgt that contains other wgts
    property int widgetsSizeRectWidth: 0
    property int widgetsSizeRectHeight: 0

    property bool isGrid: false
    property int gridStep
    property alias gridOpacity: gridCanvas.opacity
    property int gridLineType
    property string gridLineColor
    property real gridLineWidth

    property bool isSnap: false
    property int snapSpacing: 5

    property int maxAvailableWidth: contentWidth - width
    property int maxAvailableHeight: contentHeight - height

    signal selectedWidgetReplaced(var wgt)

    function moveScrollBar(wheel, scrollBar){
      if (wheel.angleDelta.y > 0) scrollBar.decrease(); else scrollBar.increase()
    }

    function setSelectedWidget(wgt){
      if(wgt === null) return
      if(flick.selectedWidget !== null) flick.selectedWidget.isSelected = false
      flick.selectedWidget = wgt
      flick.selectedWidget.isSelected = true
    }

    function createSelectionWidget(selection){
      var swgt = WidgetFactory.createWidget(8, flick)
      selection.forEach( wgt => { wgt.isSelected = false; wgt.parent = swgt.content })

      swgt.x = swgt.content.childrenRect.x
      swgt.y = swgt.content.childrenRect.y
      swgt.width = swgt.content.childrenRect.width
      swgt.height = swgt.content.childrenRect.height

      selection.forEach( wgt => { wgt.x = wgt.x - swgt.x; wgt.y = wgt.y - swgt.y })

      return swgt
    }

    function updateWidgetsSizeRect(){
      widgetsSizeRectWidth = Math.max(...[...widgets].map(wgt => (wgt.x + wgt.width)))
      widgetsSizeRectHeight = Math.max(...[...widgets].map(wgt => (wgt.y + wgt.height)))
    }

    function adjustWidgetsPositionsToGrid(){ widgets.forEach(wgt => { wgt.adjustPositionToGrid() }) }

    anchors.fill: parent
    interactive: false
    clip: true

    onWidthChanged:  gridCanvas.requestPaint()
    onHeightChanged: gridCanvas.requestPaint()

    contentWidth:  Math.max(width, widgetsSizeRectWidth)
    contentHeight: Math.max(height, widgetsSizeRectHeight)

    onContentXChanged: hBar.adjustHBarIndicator()
    onContentYChanged: vBar.adjustVBarIndicator()

    onSelectedWidgetChanged: root.selectionChanged(flick.selectedWidget)

    DropArea{
      id: dropArea

      anchors.fill: parent
      keys: ["widget"]

      onDropped: dragEvent => {
                   var widget = WidgetFactory.createWidget(dragEvent.source.widgetType, flick, flick.widgets.size, dragEvent.x, dragEvent.y)
                   flick.setSelectedWidget(widget)
                   flick.widgets.add(widget)
                   flick.updateWidgetsSizeRect()
                 }
    }

    // selectionRect
    Rectangle{
      id: selectionRect

      function isContains(item){
        const l1 = selectionRect.x; const r1 = selectionRect.x + selectionRect.width
        const t1 = selectionRect.y; const b1 = selectionRect.y + selectionRect.height

        let l2 = item.x; let r2 = item.x + item.width
        let t2 = item.y; let b2 = item.y + item.height

        return (l1 < l2 && r1 > r2 && t1 < t2 && b1 > b2)
      }

      x: 0; y: 0
      width: 0; height: 0
      color: Styles.primary.transparent
      border.color: Styles.primary.base
    }

    // to move over flickable using middle mouse button
    DragHandler{
      id: dragHandler

      property real startX
      property real startY

      acceptedButtons: Qt.MiddleButton
      dragThreshold: 0
      target: null

      objectName: "drag handler"

      onActiveChanged:{
        if(active){ startX = flick.contentX; startY = flick.contentY }
      }
      onTranslationChanged:{
        const deltaX = startX - translation.x; const deltaY = startY - translation.y
        flick.contentX = deltaX < 0 ? 0 : (deltaX > flick.maxAvailableWidth) ? flick.maxAvailableWidth : deltaX
        flick.contentY = deltaY < 0 ? 0 : (deltaY > flick.maxAvailableHeight) ? flick.maxAvailableHeight : deltaY
      }
    }

    MouseArea{
      id: flickMA

      property point lastPressPoint: Qt.point(0,0)

      anchors.fill: parent
      objectName: "mouse area"
      propagateComposedEvents: true
      cursorShape: dragHandler.active ? Qt.ClosedHandCursor : Qt.ArrowCursor

      onPressed: mouse => {
                   if(flick.selectedWidget !== null) { flick.selectedWidget.isSelected = false; flick.selectedWidget = null };
                   lastPressPoint.x = mouse.x;
                   lastPressPoint.y = mouse.y;
                 }
      onPositionChanged: mouse => {
                           selectionRect.x = Math.min(lastPressPoint.x, mouse.x)
                           selectionRect.y = Math.min(lastPressPoint.y, mouse.y)
                           selectionRect.width = Math.abs(lastPressPoint.x - mouse.x);
                           selectionRect.height =  Math.abs(lastPressPoint.y - mouse.y);

                         }
      onReleased:{
        var selection = []
        flick.widgets.forEach(wgt => { if (selectionRect.isContains(wgt)) selection.push(wgt) })

        flick.setSelectedWidget(
              selection.length >= 2 ? flick.createSelectionWidget(selection) :
                                      selection.length === 1 ? selection.pop() : null
              )

        selectionRect.x = 0;
        selectionRect.y = 0;
        selectionRect.width = 0;
        selectionRect.height = 0;
      }
      onWheel: wheel => { flick.moveScrollBar(wheel, wheel.modifiers && Qt.ControlModifier ? hBar : vBar) }
    }

    Canvas{
      id: gridCanvas

      onPaint:{

        var ctx = getContext("2d")
        ctx.lineWidth = flick.gridLineWidth
        switch(flick.gridLineType){
        case 1:{ // DashLine
          const space = flick.gridStep/flick.gridLineWidth/10
          const line = flick.gridStep/flick.gridLineWidth/10
          ctx.setLineDash([line, space, line])
          break
        }
        case 2:{ // DotLine
          const dot = 1
          const space = flick.gridStep/flick.gridLineWidth/10 - 1
          ctx.setLineDash([dot, space])
          break
        }
        case 3:{ // DashDotLine
          const dot = 1
          const line = (flick.gridStep/flick.gridLineWidth/3-1)/3
          const space = line
          ctx.setLineDash([line, space, dot, space])
          break
        }
        }

        ctx.strokeStyle = flick.gridLineColor

        let y = ctx.lineWidth/2
        ctx.beginPath()
        while(y < flick.contentHeight){
          ctx.moveTo(0.0, y)
          ctx.lineTo(flick.contentWidth, y)
          y += flick.gridStep
        }
        ctx.stroke()

        let x = ctx.lineWidth/2
        ctx.beginPath()
        while(x < flick.contentWidth){
          ctx.moveTo(x, 0.0)
          ctx.lineTo(x, flick.contentHeight)
          x += flick.gridStep
        }
        ctx.stroke()
      }

      anchors.fill: parent
      visible: flick.isGrid

      Component.onCompleted: { requestPaint() }
    }
  }

  QxScrollBar{
    id: vBar

    view: flick
    width: 8
    orientation: Qt.Vertical
    color: "transparent"

    iradius: vBar.width/2
    icolor: Styles.background.dp01
    iopacity: 0.5
    iborderc: "gray"
    iborderw: 1
  }

  QxScrollBar{
    id: hBar

    view: flick
    height: 8
    orientation: Qt.Horizontal
    color: "transparent"

    iradius: hBar.width/2
    icolor: Styles.background.dp01
    iopacity: 0.5
    iborderc: "gray"
    iborderw: 1
  }
}



