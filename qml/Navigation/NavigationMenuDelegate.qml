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

    property alias text: txt

    RowLayout{
        id: rootRL

        anchors.fill: parent
        spacing: 20

        Item{
            Layout.preferredWidth: 25; Layout.preferredHeight: 25
            Layout.leftMargin: 10

            Image{
                id: icon

                anchors.fill: parent
                source: iconPath
                smooth: true
                mipmap: true
                visible: false
            }
            Rectangle{
                id: colorRect

                anchors.fill: parent
                visible: false
            }
            OpacityMask{
                id: mask

                anchors.fill: colorRect
                source: colorRect
                maskSource: icon
            }
        }

        Text{
            id: txt

            Layout.fillWidth: true
            Layout.alignment: Qt.AlignVCenter
            text: name
            color: AppStyle.foreground
            opacity: AppStyle.emphasis.high
            font: AppStyle.fonts.title
        }
    }

    states:[
        State{
            name: "selected"; when: root.ListView.view.currentIndex === index
            PropertyChanges{target: colorRect; color: AppStyle.primary.base}
            PropertyChanges{target: txt; color: AppStyle.primary.base; opacity: 1.0}
        },
        State{
            name: "unselected"; when: root.ListView.view.currentIndex !== index
            PropertyChanges{target: colorRect; color: "gray"}
            PropertyChanges{target: txt; color: AppStyle.foreground; opacity: AppStyle.emphasis.medium}
        }
    ]

    MouseArea{
        anchors.fill: parent
        onClicked:{ root.ListView.view.currentIndex = index }
    }
}





