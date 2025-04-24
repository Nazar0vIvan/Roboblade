import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.2

// needs to add due to Qt6.3 and Windows bug: control.pressed doesn't work on Windows
import QtQuick.Controls.Basic

import AppStyles 1.0

ToolButton{
    id: control

    required property int type
    required property string iconPath
    required property var todo
    required property int size

    property var toolBar
    property bool isDropDown: false
    property real aspectRatio: image.implicitWidth/image.implicitHeight

    property color pressedColor: Styles.secondary.base
    property color hoverColor: Styles.secondary.light
    property color defaultColor: Styles.foreground.high

    implicitWidth: controlRL.width
    implicitHeight: image.height

    background: Rectangle{ color: "transparent" }
    action: control.todo

    RowLayout{
        id: controlRL

        height: parent.height

        AppIcon{
            id: image

            // aspectRation > 1 => width > height => height = size and width must be increased
            Layout.preferredWidth:  aspectRatio < 2 ? control.size*aspectRatio : control.size
            Layout.preferredHeight: control.size
            Layout.alignment: Qt.AlignCenter

            source: control.iconPath
            color: control.action.checkable ? control.action.checked ? pressedColor : imageMA.containsMouse ? hoverColor : defaultColor
                                            : imageMA.pressed ? pressedColor : imageMA.containsMouse ? hoverColor : defaultColor

            MouseArea{
                id: imageMA

                anchors.fill: parent
                hoverEnabled: true
                onClicked: mouse => { if(control.action.checkable) control.action.toggle(); else control.action.trigger() }
            }
        }
    }

    Component.onCompleted:{
        if(isDropDown) popup.parent = controlRL
        if(control.section === "dragMode") toolBar.addToSnaps(control)
    }

    /// ### ///
    // only if control.type equals "widget", then we add draggable features to the tool button
    Loader{
        id: draggableLoader

        Component.onCompleted: {
            if(control.type >= 0 && control.type <= 8){
                sourceComponent = draggableComponent;
                imageMA.drag.target = draggableLoader.item
            }
        }
    }
    Component{
        id: draggableComponent

        Item {
            property int widgetType: control.type

            implicitWidth: image.width; implicitHeight: image.height
            Drag.active: imageMA.drag.active
            Drag.mimeData: { "widget": 1 }
            Drag.dragType: Drag.Automatic
        }
    }
    /// ### ///

    /// ### ///
    // only if control.isDropDown equals true, then we add dropdown button to the tool button
    Loader{
        id: dropDownButtonLoader
        Component.onCompleted: {
            if(isDropDown){
                sourceComponent = dropDownButtonComponent;
                dropDownButtonLoader.item.parent = controlRL
            }
        }
    }
    Component{
        id: dropDownButtonComponent

        Button{
            id: dropDownButton

            implicitWidth: 12; implicitHeight: control.height
            background: Rectangle{ color: "transparent" }
            padding: 0
            topPadding: dropDownButton.hovered ? 5 : 0
            Behavior on topPadding {NumberAnimation {duration: 100} }
            contentItem: Image{
                source: "file:///" + applicationDirPath + "/icons/arrow_down.svg"
                fillMode: Image.PreserveAspectFit
                mipmap: true
            }
            onPressed: { control.popup.visible = true }
        }
    }
    /// ### ///
}









