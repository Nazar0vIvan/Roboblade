import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.2
import Qt5Compat.GraphicalEffects

import AppStyle 1.0

Item{
    id: root

    // if delegate contains at least one custom required property,
    // then model properties which delegate use (index, name etc),
    // must be specified as required properties (declare them EXPLICITLY!)
    required property int index
    required property string name
    required property string iconPath

    property font font: AppStyle.fonts.body
    property int spacing
    property int iconSize
    property int leftMargin
    property color selectionIconColor
    property color selectionTextColor
    property color defaultIconColor
    property color defaultTextColor

    implicitWidth: childrenRect.width

    RowLayout{
        id: rootRL

        height: parent.height
        spacing: root.spacing

        AppIcon{
            id: icon

            Layout.preferredWidth: root.iconSize; Layout.preferredHeight: root.iconSize
            Layout.leftMargin: root.leftMargin
            source: iconPath
            color: "gray"
        }

        Text{
            id: txt

            Layout.alignment: Qt.AlignVCenter
            Layout.rightMargin: 10
            text: name
            font: root.font
            color: AppStyle.foreground
            opacity: AppStyle.emphasis.high
        }
    }

    states:[
        State{
            name: "selected"; when: root.ListView.view.currentIndex === index
            PropertyChanges{ target: icon; color: root.selectionIconColor }
            PropertyChanges{ target: txt; color: root.selectionTextColor; opacity: 1.0 }
        },
        State{
            name: "unselected"; when: root.ListView.view.currentIndex !== index
            PropertyChanges{ target: icon; color: root.defaultIconColor}
            PropertyChanges{ target: txt; color: root.defaultTextColor; opacity: AppStyle.emphasis.medium }
        }
    ]

    MouseArea{
        anchors.fill: parent
        onClicked:{ root.ListView.view.currentIndex = index }
    }
}





