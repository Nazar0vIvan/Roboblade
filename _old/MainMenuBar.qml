import QtQuick 2.12
import QtQuick.Controls 2.12
import Qt.labs.settings 1.0

import AppStyle 1.0

Rectangle{
    id: root

    color: AppStyle.background

//    Loader{
//        id: settingsWindowLoader
//    }

    MenuBar{
        delegate: MenuBarItem {
            id: menuBarItem
            background: Rectangle{
                id: backgroundRect
                height: root.height
                color: menuBarItem.highlighted ? AppStyle.highlight : "transparent"
            }
            contentItem: Text {
                text: menuBarItem.text
                font: AppStyle.fonts.subtitle
                color: AppStyle.foreground
                opacity: AppStyle.elevation.high
                anchors.verticalCenter: backgroundRect.verticalCenter
            }
        }
        background: Rectangle{
            color: "transparent"
        }

        Menu{
            id: fileMenu
            title: qsTr("File")
            Action{ text: qsTr("Open...") }
            Action{ text: qsTr("Save") }
            Action{ text: qsTr("Save As...") }
            Action{ text: qsTr("New...") }
            MenuSeparator { }
            Action{ text: qsTr("Quit") }
        }
        Menu{
            id: editMenu
            title: qsTr("Edit")
        }

        Menu{
            id: helpMenu
            title: qsTr("Help")
            Action { text: qsTr("Documentation...") }
        }
    }
}
