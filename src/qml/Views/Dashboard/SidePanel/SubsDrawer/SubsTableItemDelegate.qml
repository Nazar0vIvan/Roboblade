import QtQuick 2.12
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

import qml.Modules.Styles 1.0

ItemDelegate{
  id: control

  property real overlayOpacity: 0.0
  property color color: Styles.foreground.high

  font: Styles.fonts.body

  contentItem: Text{
    verticalAlignment: Text.AlignVCenter
    text: control.text
    font: control.font
    color: control.color
  }

  background: Rectangle{
    color: Styles.foreground.high
    opacity: control.overlayOpacity
  }
}

/*
Rectangle{
    id: control

    property bool checkable: false
    property bool first: false
    property bool last: false
    property alias text: txtEdit.text
    property alias textColor: txtEdit.color
    property alias font: txtEdit.font
    property bool isExclusiveSelection: false

    signal clicked()

    color: "transparent"

    Rectangle{
        id: overlay;

        anchors.fill: parent
        color: Styles.foreground
        opacity: 0.10
        visible: control.selected
    }

    RowLayout{
        id: controlRL

        anchors{ fill: parent; leftMargin: control.first ? 10 : 0 }
        spacing: 10

        TextEdit{
            id: txtEdit

            Layout.fillWidth: true; Layout.preferredHeight: control.height
            verticalAlignment: Text.AlignVCenter
            color: Styles.foreground
            font: Styles.fonts.caption
            opacity: control.enabled ? Styles.emphasis.high : Styles.emphasis.disabled
            selectionColor: Styles.primary.highlight
            selectByMouse : true
            readOnly: true
        }
    }

    // --> CHECKBOX LOADER
    Loader{
        id: checkBoxLoader

        Component.onCompleted:{
            if(control.checkable){
                sourceComponent = checkboxComponent
                controlRL.children[0] = checkBoxLoader.item
                controlRL.children.push(txtEdit)
            }
        }
    }
    Component{
        id: checkboxComponent

        AbstractButton{
            id: checkbox

            implicitWidth: 18; implicitHeight: 18
            checkable: true
            checked: control.selected

            contentItem: Rectangle{
                anchors.verticalCenter: parent.verticalCenter
                implicitWidth: 16; implicitHeight: implicitWidth
                color: checkbox.checked && !isExclusiveSelection ? Styles.secondary.base : "transparent"
                border{ width: 1; color: checkbox.checked ? Styles.secondary.base : "gray" }
                radius: isExclusiveSelection ? implicitWidth/2 : 2

                Rectangle{ // radiobutton pick
                    anchors.centerIn: parent
                    width: 10; height: width
                    color: Styles.secondary.base
                    radius: width/2
                    antialiasing: true
                    visible: checkbox.checked && isExclusiveSelection
                }

                Image{ // checkbox pick
                    anchors.centerIn: parent
                    width: 12; height: width
                    source: "/dashboard/tick.svg"
                    fillMode: Image.PreserveAspectFit
                    smooth: true
                    mipmap: true
                    visible: checkbox.checked && !isExclusiveSelection
                }
            }

            onClicked: mouse => control.clicked()
        }
    }
    // <-- CHECKBOX LOADER

    // --> INDICATOR LOADER
    Loader{
        id: selectIndicatorLoader

        Component.onCompleted: {
            if(control.last){
                sourceComponent = selectIndicatorComponent
                selectIndicatorLoader.item.parent = controlRL
                selectIndicatorLoader.item.Layout.preferredHeight = parent.height
            }
        }
    }
    Component{
        id: selectIndicatorComponent

        Rectangle{
            id: selectIndicator

            implicitWidth: 2
            color: Styles.secondary.base
            visible: control.selected
        }
    }
    // <-- INDICATOR LOADER
}
*/

