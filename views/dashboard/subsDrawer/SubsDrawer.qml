import QtQuick 2.12
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import Qt.labs.qmlmodels

import AppStyle 1.0
import Components 1.0

// change checkbox rectangle to circle in case of widget types 0 and 1
// make unique parameter pick for widget types 0 and 1

Drawer{
    id: root

    property int _searchBarHeight: 30
    property int _searhBarWidth: 150
    property var widget: null

    edge: Qt.RightEdge
    closePolicy: Popup.NoAutoClose
    modal: false
    background: Rectangle{
        color: AppStyle.background
        border{ width: 1; color: "gray" }
    }

    ColumnLayout{
        id: rootCL

        anchors{ fill: parent; margins: 14 }
        spacing: 0

        RowLayout{
            id: topRL

            Layout.fillWidth: true; Layout.preferredHeight: 24
            Layout.bottomMargin: 5

            Text{
                id: socketsTitle

                Layout.fillWidth: true; Layout.alignment: Qt.AlignLeft
                text: qsTr("Sockets")
                font: AppStyle.fonts.headline2
                color: AppStyle.foreground
                opacity: AppStyle.emphasis.high
            }

            AppToolButton{
                id: hideToolButton

                Layout.preferredWidth: 24; Layout.preferredHeight: 24
                type: 9
                iconPath: "/dashboard/allow_left_long.png"
                todo: Action{ onTriggered: { root.visible = false } }
                size: 18

                pressedColor: AppStyle.secondary.base
                hoverColor: AppStyle.secondary.light
                defaultColor: AppStyle.secondary.base
            }
        }

        TabBar{
            id: tabBar

            property int interval: 35

            Layout.fillWidth: true; Layout.preferredHeight: 35
            spacing: 0
            background: Rectangle{
                color: "transparent"
                Rectangle{
                    anchors.bottom: parent.bottom
                    width: parent.width; height: 1
                    color: AppStyle.foreground
                    opacity: AppStyle.emphasis.disabled
                }
            }

            AppTabButton{
                id: krcTabButton

                anchors.verticalCenter: parent.verticalCenter
                width: tabBar.interval + contentItem.implicitWidth
                height: 35
                text: qsTr("KR C4")
            }
            AppTabButton{
                id: ftsTabButton

                anchors.verticalCenter: parent.verticalCenter
                width: tabBar.interval + contentItem.implicitWidth
                height: 35
                text: qsTr("F/T Sensor")
            }
            AppTabButton{
                id: houTabButton

                anchors.verticalCenter: parent.verticalCenter
                width: tabBar.interval + contentItem.implicitWidth
                height: 35
                text: qsTr("Houdini")
            }
            AppTabButton{
                id: vfdTabButton

                anchors.verticalCenter: parent.verticalCenter
                width: tabBar.interval + contentItem.implicitWidth
                height: 35
                text: qsTr("VFD/A65")
            }

            onCurrentIndexChanged: {
                switch(currentIndex){
                    case 0: subsTable.updateModel(socketRSI.parmsModel); break
                    case 1: subsTable.updateModel(socketRDT.parmsModel); break
                    case 2: subsTable.updateModel(socketHou.parmsModel); break
                }
            }
        }

        Text{
            id: parmsTitle

            Layout.topMargin: 16; Layout.bottomMargin: 16
            text: qsTr("Parameters")
            font: AppStyle.fonts.headline2
            color: AppStyle.foreground
            opacity: AppStyle.emphasis.high
        }

        RowLayout{
            id: searchBar

            Layout.fillWidth: true; Layout.preferredHeight: root._searchBarHeight
            Layout.bottomMargin: 10

            TextField{
                id: searchField

                Layout.preferredWidth: root._searhBarWidth
                Layout.preferredHeight: root._searchBarHeight
                verticalAlignment: Text.AlignVCenter

                background: Rectangle{
                    color: "transparent"
                    border{width: 0.8; color: "gray"}
                    radius: 4
                }

                leftPadding: root._searchBarHeight + 8
                font: AppStyle.fonts.caption
                color: AppStyle.foreground
                opacity: AppStyle.emphasis.high
                activeFocusOnPress: true

                RowLayout{
                    id: searchFieldRL

                    anchors.fill: parent
                    spacing: 10

                    Image{
                        id: searchIcon

                        Layout.preferredWidth: root._searchBarHeight - 14
                        Layout.preferredHeight: root._searchBarHeight - 14
                        Layout.leftMargin: 8
                        source: "/dashboard/search.svg"
                        fillMode: Image.PreserveAspectFit
                        mipmap: true
                    }

                    Text{
                        id: searchTxt

                        Layout.fillWidth: true
                        Layout.alignment: Qt.AlignLeft
                        text: qsTr("Search ...")
                        font: AppStyle.fonts.caption
                        color: AppStyle.foreground
                        opacity: AppStyle.emphasis.medium
                        visible: !(searchField.activeFocus || searchField.text)
                    }
                }
            }

            Rectangle{ Layout.fillWidth: true }

            RowLayout{
                id: toolButtonsRL

                height: root._searchBarHeight
                spacing: 10

                AppToolButton{
                    size: root._searchBarHeight - 12
                    type: 9
                    iconPath: "/dashboard/eraser.svg"
                    todo: Action{}
                }

                AppToolButton{
                    size: root._searchBarHeight - 12
                    type: 9
                    iconPath: "/dashboard/settings.svg"
                    todo: Action{}
                }
            }
        }

        SubsTable{
            id: subsTable

            Layout.fillWidth: true; Layout.fillHeight: true
            model: socketRSI.parmsModel
            widget: root.widget
        }

        Rectangle{
            Layout.fillWidth: true; Layout.preferredHeight: root._searchBarHeight
            color: AppStyle.surface
        }
    }

}
