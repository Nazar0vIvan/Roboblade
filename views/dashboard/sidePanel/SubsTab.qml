import QtQuick 2.12
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

import AppStyle 1.0
import Components 1.0

Item{
    id: root

    signal subsPopupStateChanged()

    property bool isSubsPopupOpen: false
    property alias enabled: subsButton.enabled

    ColumnLayout{
        id: rootCL

        anchors{ fill: parent; margins: 10 }

        Rectangle{
            id: subsInfo

            Layout.fillWidth: true; Layout.fillHeight: true
            color: AppStyle.surface
        }

        AppButton{
            id: subsButton

            Layout.preferredHeight: 30;  Layout.preferredWidth: 100;
            Layout.alignment: Qt.AlignLeft
            leftPadding: 10
            text: qsTr("Subscribe")
            font: AppStyle.fonts.caption
            backgroundColor: AppStyle.secondary.base
            color: AppStyle.background
            hoverEnabled: enabled
            enabled: false

            iconSize: 16
            iconPath: "/dashboard/arrow_left.png"
            iconColor: enabled ? "black" : "gray"

            onClicked: { root.subsPopupStateChanged() }
            onHoveredChanged: shiftAnimation.start()

//            NumberAnimation{
//                id: rotateAnimation

//                target: subsButton.contentItem.icon
//                from: isSubsPopupOpen ? 180 : 0
//                to:   isSubsPopupOpen ? 0 : 180
//                property: "rotation";
//                duration: 200
//            }
            NumberAnimation{
                id: shiftAnimation

                target: subsButton.contentItem.icon
                from: subsButton.hovered ? -subsButton.iconSize/3 : 0
                to:   subsButton.hovered ? 0 : -subsButton.iconSize/3
                property: "x";
                duration: 200
            }
        }
    }
}