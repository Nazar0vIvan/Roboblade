import QtQuick 2.12
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.2

import AppStyle 1.0

MenuBar{
    id: menuBar

    leftPadding: 10

    Menu{
        title: qsTr("File")
        MenuItem { text: qsTr("New...") }
        MenuItem { text: qsTr("Open...") }
        MenuItem { text: qsTr("Save") }
        MenuItem { text: qsTr("Save &As...") }
        MenuSeparator { }
        MenuItem { text: qsTr("Quit") }
    }

    Menu{
        title: qsTr("Edit")
        MenuItem { text: qsTr("Cut") }
        MenuItem { text: qsTr("Copy") }
        MenuItem { text: qsTr("Paste") }
    }

    Menu{
        title: qsTr("View")
    }
    Menu{
        title: qsTr("Help")
    }

    delegate: MenuBarItem{
        id: menuBarItem

        contentItem: Text{

            verticalAlignment: Text.AlignVCenter
            leftPadding: 10; rightPadding: 10
            text: menuBarItem.text
            font: AppStyle.fonts.body
            color: AppStyle.foreground
            opacity: AppStyle.emphasis.high

        }

        background: Rectangle{
            color: menuBarItem.hovered ? AppStyle.primary.transparent : "transparent"
        }
    }
    background: Rectangle{ color: AppStyle.background }
}



