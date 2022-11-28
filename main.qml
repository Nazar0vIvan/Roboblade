import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0

import "navigation"
import "views/settings"
import "views/dashboard"
import "views/network"
import "views/scene"

import AppStyle 1.0

ApplicationWindow{
    id: app

    width: 1100; height: 650
    color: "#353535" // AppStyle.surface
    title: qsTr("Roboblade")
    visible: true

    menuBar: AppMenuBar{ height: 30 }

    SplitView{ // top - logger
        id: vSplitView

        anchors.fill: parent
        orientation: Qt.Vertical
        handle: Rectangle{
            implicitHeight: 1
            color: SplitHandle.pressed | SplitHandle.hovered ? AppStyle.foreground : "transparent"
            opacity: SplitHandle.pressed ? AppStyle.emphasis.high : (SplitHandle.hovered ? AppStyle.emphasis.medium : 1.0)
        }

        SplitView{ // navigation nav - view
            id: hSplitView

            SplitView.fillWidth: true; SplitView.fillHeight: true
            orientation: Qt.Horizontal
            handle: Rectangle{
                implicitWidth: 1
                color: SplitHandle.pressed | SplitHandle.hovered ? AppStyle.foreground : "transparent"
                opacity: SplitHandle.pressed ? AppStyle.emphasis.high: (SplitHandle.hovered ? AppStyle.emphasis.medium : 1.0)
            }

            NavigationPanel{
                id: navigationPanel

                SplitView.preferredWidth: 50; SplitView.fillHeight: true
                SplitView.minimumWidth: 50; SplitView.maximumWidth: 50
                color: AppStyle.navigationPanelBackground
            }

            StackLayout{
                id: sl

                SplitView.fillHeight: true; SplitView.fillWidth: true

                currentIndex: navigationPanel.currentIndex

                Dashboard{ id: dashboard }

                Scene{ id: scene }

                Network{ id: network }

                SettingsView{ id: settingsView }
            }
        }

        Logger{
            SplitView.fillWidth: true; SplitView.preferredHeight: 0
            SplitView.maximumHeight: 200
        }
    }
}
