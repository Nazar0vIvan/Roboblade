import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.2
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
    color: AppStyle.surface
    title: qsTr("Roboblade")
    visible: true

     SplitView{ // top - logger
        id: verticalSplit

        anchors.fill: parent
        orientation: Qt.Vertical
        handle: Rectangle{
            implicitHeight: 4
            color: SplitHandle.pressed | SplitHandle.hovered ? AppStyle.foreground : "transparent"
            opacity: SplitHandle.pressed ? AppStyle.emphasis.high : (SplitHandle.hovered ? AppStyle.emphasis.medium : 1)
        }

        SplitView{ // navigation menu - view
            id: horizontalSplit

            SplitView.fillWidth: true; SplitView.fillHeight: true
            orientation: Qt.Horizontal
            handle: Rectangle{
                implicitWidth: 4
                color: SplitHandle.pressed | SplitHandle.hovered ? AppStyle.foreground : "transparent"
                opacity: SplitHandle.pressed ? AppStyle.emphasis.high : (SplitHandle.hovered ? AppStyle.emphasis.medium : 1)
            }

            NavigationPanel{
                id: navigationPanel

                SplitView.preferredWidth: 220; SplitView.fillHeight: true
                SplitView.minimumWidth: 85; SplitView.maximumWidth: 220
                color: AppStyle.background
                onWidthChanged:{ // logo opacity
                    var min = SplitView.minimumWidth; var max = SplitView.maximumWidth
                    navigationPanel.txtLogoOpacity = 1/(max-min)*width - min/(max-min)
                }
                onCurrentIndexChanged: index => { stackView.replace(stackView.children[index], StackView.Immediate) }
            }

            StackView{
                id: stackView

                SplitView.fillHeight: true; SplitView.fillWidth: true

                Dashboard{ id: dashboard; visible: true }

                Scene{ id: scene; visible: false}

                Network{ id: network; visible: false }

                SettingsView{ id: settingsView; visible: false }

                Rectangle{ id: help; width: 50; height: 50; color: "blue"; visible: false }
            }
        }

        Logger{
            SplitView.fillWidth: true; SplitView.preferredHeight: 0
            SplitView.maximumHeight: 200
        }
    }
}
