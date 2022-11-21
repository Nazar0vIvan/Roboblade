import QtQuick 2.12
import QtQuick.Controls 2.15

Rectangle {
    id: root

    required property var view // flickable

    property int orientation: Qt.Vertical
    property real step: 0.05

    property alias iradius: indicator.radius
    property alias icolor: indicator.color
    // alias indicator.opacity won't work because alias property
    // must be initialized during DashboardScrollBar creation, but
    // not outside - at DashboardScene in Dashboard.qml where opacity
    // will be rebinded after assigment
    property real iopacity
    // group properties can't be aliased
    // if try alias indicator.anchors.leftMargin - error (but in docs it's alowed!)
    // indicator.border.width and indicator.border.color - same issue
    property int iborderw
    property color iborderc

    property int maximumDragX: root.view.width - indicator.width - root.height
    property int maximumDragY: root.view.height - indicator.height - root.width

    function increase(){
        if (root.orientation === Qt.Vertical)
            indicator.y = Math.min(root.maximumDragY, indicator.y + root.step*(root.height - indicator.height))
        else
            indicator.x = Math.min(root.maximumDragX, indicator.x + root.step*(root.width - indicator.width))
    }
    function decrease(){
        if (root.orientation === Qt.Vertical)
            indicator.y = Math.max(0, indicator.y - root.step*(root.height - indicator.height))
        else
            indicator.x = Math.max(0, indicator.x - root.step*(root.width - indicator.width))
    }

    function adjustHBarIndicator(){ indicator.x = (root.maximumDragX/view.maxAvailableWidth) * view.contentX }
    function adjustVBarIndicator(){ indicator.y = (root.maximumDragY/view.maxAvailableHeight) * view.contentY }

    anchors{
        top: if(orientation === Qt.Vertical) view.top
        left: if(orientation === Qt.Horizontal) view.left
        right: view.right
        bottom: view.bottom
        bottomMargin: if(orientation === Qt.Vertical) root.width; else 2
        rightMargin: if(orientation === Qt.Horizontal) root.height; else 2
    }
    visible: (root.orientation === Qt.Vertical ) ? view.visibleArea.heightRatio < 1 ? true : false :
                                                   view.visibleArea.widthRatio < 1 ? true : false

    color: "white"
    opacity: (mouseArea.pressed || mouseArea.containsMouse) ? 2*iopacity : iopacity

    Rectangle{
        id: indicator

        anchors{
            horizontalCenter: if(orientation === Qt.Vertical) parent.horizontalCenter
            verticalCenter: if(orientation === Qt.Horizontal) parent.verticalCenter
        }
        width: orientation === Qt.Horizontal ? view.visibleArea.widthRatio * (root.view.width - indicator.height) : root.width
        height: orientation === Qt.Vertical ? view.visibleArea.heightRatio * (root.view.height - indicator.width) : root.height
        color: "gray"
        border{ width: root.iborderw; color: iborderc }
        antialiasing: true

        onXChanged: { view.contentX = (view.maxAvailableWidth/root.maximumDragX) * indicator.x }
        onYChanged: { view.contentY = (view.maxAvailableHeight/root.maximumDragY) * indicator.y }

        MouseArea{
            id: mouseArea

            anchors.fill: parent
            hoverEnabled: true
            drag.target: indicator
            drag.axis: orientation === Qt.Vertical ? Drag.YAxis : Drag.XAxis
            drag.minimumX: 0; drag.minimumY: 0
            drag.maximumX: root.maximumDragX // root.view.width - indicator.width - root.height
            drag.maximumY: root.maximumDragY // root.view.height - indicator.height - root.width
        }
    }
}
