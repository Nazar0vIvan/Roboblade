import QtQuick 2.12
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.2
import QtQml.Models 2.15

import qml.Modules.Styles 1.0

Item{
    id: root

    enum ResizeType{ TopLeft, TopRight, BottomLeft, BottomRight, Left, Right, Top, Bottom, None }

    property var resizeMark: { "w": 10, "h": 10 }
    property int resizeType: DashboardWidget.ResizeType.None
    property int type: 8
    property int serial
    property var flick

    property int minimumWidth: 0
    property int minimumHeight: 0
    property int maximumWidth: 1000
    property int maximumHeight: 1000

    property bool isSelected: true
    property bool isSquare: false

    // socket name -> set of parameter's names
    property var subs: new Map([
                                [socketRSI.parmsModel.id,    new Set([])],
                                [socketRDT.parmsModel.id,    new Set([])],
                                [socketHou.parmsModel.id,    new Set([])],
                                [socketVFDA65.parmsModel.id, new Set([])]
                               ])

    property alias content: content
    property alias background: background

    function addWidget(wgt){
        wgt.parent = content
        wgt.x = wgt.x - root.x; wgt.y = wgt.y - root.y
        const oldOrigin = Qt.point(content.childrenRect.x, content.childrenRect.y)

        root.x = root.x + content.childrenRect.x
        root.y = root.y + content.childrenRect.y
        root.width = content.childrenRect.width
        root.height = content.childrenRect.height

        for(let i = 0; i < content.children.length; ++i){
            const child = content.children[i]
            child.x = child.x - oldOrigin.x
            child.y = child.y - oldOrigin.y
        }
    }

    function removeWidget(wgt) {
        wgt.parent = flick.contentItem
        wgt.x = wgt.x + root.x; wgt.y = wgt.y + root.y
        const oldOrigin = Qt.point(content.childrenRect.x, content.childrenRect.y)

        root.x = root.x + content.childrenRect.x
        root.y = root.y + content.childrenRect.y
        root.width = content.childrenRect.width
        root.height = content.childrenRect.height

        for(let i = 0; i < content.children.length; ++i){
            content.children[i].x = content.children[i].x - oldOrigin.x
            content.children[i].y = content.children[i].y - oldOrigin.y
        }
    }

    function adjustPositionToGrid(){
        root.x = Math.round(root.x/flick.gridStep)*flick.gridStep
        root.y = Math.round(root.y/flick.gridStep)*flick.gridStep
    }

    focus: isSelected
    Drag.active: rootMA.drag.active

    Rectangle{
        id: background

        anchors.fill: parent
        color: content.children.length ? "transparent" : Styles.background.dp01
        radius: 0
        border{ width: 1; color: "gray" }
    }

    Rectangle{
        id: dataTransferIndicator

        anchors{
            right: parent.right
            top: parent.top
            rightMargin: background.radius >= 10 ? root.background.radius/2 : 8
            topMargin: background.radius >= 10 ? root.background.radius/2 : 8
        }
        width: 8; height: 8
        radius: width/2
        color: Styles.maxColor
    }

    Item { id: content }

    MouseArea{
        id: rootMA

        function isCursorTopLeft(){ return ((mouseX < resizeMark.w) && (mouseY < resizeMark.h)) }
        function isCursorTopRight(){ return ((mouseX > root.width - resizeMark.w) && (mouseY < resizeMark.h)) }
        function isCursorBottomLeft(){ return ((mouseX < resizeMark.w) && (mouseY > root.height - resizeMark.h)) }
        function isCursorBottomRight(){ return ((mouseX > root.width - resizeMark.w) && (mouseY > root.height - resizeMark.h)) }
        function isCursorTop(){ return (((mouseX > resizeMark.w) && (mouseX < root.width - resizeMark.w)) && (mouseY < resizeMark.h)) }
        function isCursorBottom(){ return (((mouseX > resizeMark.w) && (mouseX < root.width - resizeMark.w)) && ((mouseY > root.height - resizeMark.h))) }
        function isCursorLeft(){ return ((mouseX < resizeMark.w) && ((mouseY > resizeMark.h) && (mouseY < rootMA.height - resizeMark.h))) }
        function isCursorRight(){ return ((mouseX > rootMA.width - resizeMark.w) && ((mouseY > resizeMark.h) && (mouseY < root.height - resizeMark.h))) }

        function resizeLeft(){
            const dbMouseX = root.mapToItem(flick.contentItem, mouseX, mouseY).x
            const oldPosX = root.x   
            const newPosX = flick.isGrid ? Math.round(dbMouseX/flick.gridStep)*flick.gridStep : dbMouseX
            const newWidth = root.width + oldPosX - newPosX
            if(newWidth < minimumWidth || newWidth > maximumWidth) return
            root.width = newWidth; root.x = newPosX
            if(isSquare) root.height = root.width
        }

        function resizeRight(){
            const newWidth = flick.isGrid ? Math.round(mouseX/flick.gridStep)*flick.gridStep : mouseX
            if(newWidth < minimumWidth || newWidth > maximumWidth) return
            root.width = newWidth
            if(isSquare) root.height = root.width
        }

        function resizeTop(){
            const dbMouseY = root.mapToItem(flick.contentItem, mouseX, mouseY).y
            const oldPosY = root.y
            const newPosY = flick.isGrid ? Math.floor(dbMouseY/flick.gridStep)*flick.gridStep : dbMouseY
            const newHeight = root.height + oldPosY - newPosY
            if(newHeight < minimumHeight || newHeight > maximumHeight) return
            root.height = newHeight; root.y = newPosY
            if(isSquare) root.width = root.height
        }

        function resizeBottom(){
            const newHeight = flick.isGrid ? Math.round(mouseY/flick.gridStep)*flick.gridStep : mouseY
            if(newHeight < minimumHeight || newHeight > maximumHeight) return
            root.height = newHeight
            if(isSquare) root.width = root.height
        }

        function resizeTopLeft(){ resizeLeft(); if(!isSquare) resizeTop() }
        function resizeTopRight(){ resizeTop(); if(!isSquare) resizeRight() }
        function resizeBottomLeft(){ resizeBottom(); if(!isSquare) resizeLeft() }
        function resizeBottomRight(){ resizeBottom(); if(!isSquare) resizeRight() }

        /* !!!!! */
        z: 5
        /* !!!!! */

        anchors{
            fill: parent
            topMargin: -resizeMark.h/2
            bottomMargin: -resizeMark.h/2
            leftMargin: -resizeMark.w/2
            rightMargin: -resizeMark.w/2
        }

        drag.target: parent
        hoverEnabled: true
        cursorShape: isCursorTopLeft()  || isCursorBottomRight() ? Qt.SizeFDiagCursor :
                     isCursorTopRight() || isCursorBottomLeft()  ? Qt.SizeBDiagCursor :
                     isCursorTop()      || isCursorBottom()      ? Qt.SizeVerCursor :
                     isCursorLeft()     || isCursorRight()       ? Qt.SizeHorCursor : Qt.ArrowCursor

        onPressed: mouse => {
            if (!root.isSelected){
                if((flick.selectedWidget !== null) && (mouse.modifiers & Qt.ShiftModifier)){
                    if(flick.selectedWidget.content.children.length){
                        flick.selectedWidget.addWidget(root)
                    }
                    else{  
                        flick.setSelectedWidget(flick.createSelectionWidget([flick.selectedWidget, root]))
                    }
                }
                else{
                    flick.setSelectedWidget(root)
                }
            }

            resizeType = isCursorTopLeft()     ? DashboardWidget.ResizeType.TopLeft :
                         isCursorTopRight()    ? DashboardWidget.ResizeType.TopRight :
                         isCursorBottomLeft()  ? DashboardWidget.ResizeType.BottomLeft :
                         isCursorBottomRight() ? DashboardWidget.ResizeType.BottomRight :
                         isCursorLeft()        ? DashboardWidget.ResizeType.Left :
                         isCursorRight()       ? DashboardWidget.ResizeType.Right :
                         isCursorTop()         ? DashboardWidget.ResizeType.Top :
                         isCursorBottom()      ? DashboardWidget.ResizeType.Bottom : DashboardWidget.ResizeType.None
        }

        onReleased: mouse => {
            if(content.children.length >= 2 && !drag.active){
                var wgt = content.childAt(mouse.x, mouse.y)
                if(wgt !== null){
                     if(mouse.modifiers & Qt.ShiftModifier){
                        root.removeWidget(wgt)
                     }
                     else{
                        flick.setSelectedWidget(wgt)
                     }
                 }
                 else{
                    root.isSelected = false
                 }
            }
            resizeType = DashboardWidget.ResizeType.None
            drag.target = parent
        }

        onPositionChanged: mouse => {
            // resizing
            if(pressed && resizeType !== DashboardWidget.ResizeType.None){
                drag.target = null
                switch (resizeType){
                    case DashboardWidget.ResizeType.Left:        resizeLeft(); break
                    case DashboardWidget.ResizeType.Right:       resizeRight(); break
                    case DashboardWidget.ResizeType.Top:         resizeTop(); break
                    case DashboardWidget.ResizeType.Bottom:      resizeBottom(); break
                    case DashboardWidget.ResizeType.TopLeft:     resizeTopLeft(); break
                    case DashboardWidget.ResizeType.TopRight:    resizeTopRight(); break
                    case DashboardWidget.ResizeType.BottomLeft:  resizeBottomLeft(); break
                    case DashboardWidget.ResizeType.BottomRight: resizeBottomRight(); break
                }
            }

            if(flick.isGrid) root.adjustPositionToGrid() // adjust position if grid on

            if(root.x < 0) root.x = 0; if(root.y < 0) root.y = 0 // drag limitation

            flick.updateWidgetsSizeRect()
        }
    }

    Rectangle{
        id: borderRect

        anchors.fill: parent
        border{ width: 1; color: Styles.secondary.base }
        color: "transparent"
        visible: (isSelected && !rootMA.drag.active)

        Rectangle{
            id: topLeft

            x: -topLeft.width/2; y: -topLeft.height/2
            width: resizeMark.w; height: resizeMark.h
            color: Styles.foreground.high
            border{ width: 1; color: Styles.secondary.base }
        }
        Rectangle{
            id: topRight

            x: borderRect.width - topRight.width/2; y: -topRight.height/2
            width: resizeMark.w; height: resizeMark.h
            color: Styles.foreground.high
            border{ width: 1; color: Styles.secondary.base }
        }
        Rectangle{
            id: bottomLeft

            x: -bottomLeft.width/2; y: -bottomLeft.height/2+borderRect.height
            width: resizeMark.w; height: resizeMark.h
            color: Styles.foreground.high
            border{ width: 1; color: Styles.secondary.base }

        }
        Rectangle{
            id: bottomRight

            x: -bottomRight.width/2+borderRect.width; y: -bottomRight.height/2+borderRect.height
            width: resizeMark.w; height: resizeMark.h
            color: Styles.foreground.high
            border{ width: 1; color: Styles.secondary.base }
        }
    }

    Keys.onDeletePressed: event => {
        flick.selectedWidget = null
        flick.widgets.delete(root)
        root.destroy()
        event.accepted = true;
    }

    Keys.onLeftPressed: event => {
        root.x -= flick.isGrid ? flick.gridStep : (event.modifiers & Qt.ShiftModifier) ? 10 : 1 }
    Keys.onRightPressed: event => {
        root.x += flick.isGrid ? flick.gridStep : (event.modifiers & Qt.ShiftModifier) ? 10 : 1 }
    Keys.onDownPressed: event => {
        root.y += flick.isGrid ? flick.gridStep : (event.modifiers & Qt.ShiftModifier) ? 10 : 1 }
    Keys.onUpPressed: event => {
        root.y -= flick.isGrid ? flick.gridStep : (event.modifiers & Qt.ShiftModifier) ? 10 : 1 }

    states:[
        State{
            name: "selected"; when: isSelected === true
            StateChangeScript{ script: root.forceActiveFocus() }
        },
        State{
            name: "unselected"; when: isSelected === false
            StateChangeScript{
                script:{
                    if(content.children.length){
                        for(var i = content.children.length - 1; i >= 0 ; i--){
                            var child = content.children[0]
                            const oldPos = Qt.point(child.x, child.y)
                            child.parent = flick.contentItem
                            child.x = root.x + oldPos.x
                            child.y = root.y + oldPos.y
                        }
                        root.destroy()
                    }
                }
            }
        }
    ]
}
