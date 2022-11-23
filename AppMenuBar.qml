import QtQuick 2.12
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.2

import AppStyle 1.0

MenuBar{
    id: menuBar

    signal open
    signal save
    signal saveAs
    signal undo
    signal redo

    Action{ id: open;   shortcut: StandardKey.Open; onTriggered: { root.open(); console.log("open") }}
    Action{ id: save;   shortcut: StandardKey.Save; onTriggered: { root.save(); console.log("save") }}
    Action{ id: saveAs; shortcut: "Ctrl+Shift+S";   onTriggered: { root.saveAs(); console.log("saveAs")}}
    Action{ id: undo;   shortcut: StandardKey.Undo; onTriggered: { root.undo(); console.log("undo") }}
    Action{ id: redo;   shortcut: StandardKey.Redo; onTriggered: { root.redo(); console.log("redo") }}

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
            leftPadding: 8; rightPadding: 8
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



