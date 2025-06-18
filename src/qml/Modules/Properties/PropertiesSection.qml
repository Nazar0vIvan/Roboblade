import QtQuick 2.12
import QtQuick.Controls 2.15
import QtQuick.Controls.Basic
import QtQuick.Layouts 1.2

import qml.Modules.Styles 1.0

Item{
    id: root

    property alias titleName: titleName.text
    readonly property int titleHeight: 40
    property list<Item> properties
    property bool isExpanded: false
    property bool isSeparator: true

    implicitWidth: Styles.drawerWidth; implicitHeight: childrenRect.height

    Behavior on height { NumberAnimation { duration: 500 } }

    // -> section ColumnLayout
    ColumnLayout{
        id: rootCL

        width: parent.width
        spacing: 0

        // -> properties section title
        Rectangle{
            id: titleRect

            Layout.fillWidth: true; Layout.preferredHeight: root.titleHeight
            Layout.alignment: Qt.AlignTop

            color: "transparent"

            Rectangle{ // separator
                id: titleSeparator

                anchors{ left: parent.left; right: parent.right }
                height: 1
                color: Styles.foreground.high
                visible: root.isSeparator
            }
            RowLayout{
                id: titleRL

                anchors{ fill: parent; leftMargin: 15; rightMargin: 5 }
                spacing: 0

                Text{
                    id: titleName

                    Layout.fillWidth: true; Layout.preferredHeight: root.titleHeight
                    Layout.alignment: Qt.AlignVCenter
                    verticalAlignment: Text.AlignVCenter
                    font: Styles.fonts.subtitle
                    color: Styles.foreground.high
                }
                Control{
                    id: titleArrow

                    Layout.preferredWidth: root.titleHeight - 10; Layout.preferredHeight: root.titleHeight - 10
                    Layout.alignment: Qt.AlignVCenter
                    background: Rectangle { color: "transparent" }
                    padding: 10
                    contentItem: Image{
                        source: "/dashboard/arrow_right.svg"
                        fillMode: Image.PreserveAspectFit
                        mipmap: true
                    }
                    transform: Rotation {
                        origin.x: titleArrow.width/2; origin.y: titleArrow.height/2
                        axis{ x: 0; y: 0; z: 1 }
                        angle: root.isExpanded ? 90 : 0

                        Behavior on angle { NumberAnimation { duration:  200 } }
                    }
                }
            }
            MouseArea{
                id: titleMA

                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: { root.isExpanded = !root.isExpanded }
            }
        }
        // <- properties section title

        // -> properties elements ColumnLayout
        ColumnLayout{
            id: propsCL

            property int maxHeight: 0

            Layout.fillWidth: true
            Layout.leftMargin: 15; Layout.rightMargin: 35; Layout.bottomMargin: 15
            Layout.alignment: Qt.AlignTop

            visible: root.isExpanded
            opacity: root.isExpanded ? 1.0 : 0

            Behavior on opacity { NumberAnimation { duration: 200 }}

            Component.onCompleted: {
                for(let i = 0; i < properties.length; ++i) { properties[i].parent = propsCL }
            }
        }
        // <- properties elements ColumnLayout

    }
    // <- section ColumnLayout


}
