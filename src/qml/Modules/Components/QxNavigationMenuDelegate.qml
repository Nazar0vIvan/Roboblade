import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.2
//import Qt5Compat.GraphicalEffects

import qml.Modules.Styles 1.0

Item{
    id: root

    // if delegate contains at least one custom required property,
    // then model properties which delegate use (index, name etc),
    // must be specified as required properties (declare them EXPLICITLY!)
    required property int index
    required property string iconPath

    property int spacing
    property int iconSize
    property color selectionIconColor
    property color defaultIconColor

    QxIcon{
        id: icon

        anchors.centerIn: parent
        implicitWidth: root.iconSize; implicitHeight: root.iconSize
        source: iconPath
        color: root.ListView.view.currentIndex === index ? root.selectionIconColor : root.defaultIconColor
    }

    MouseArea{
        anchors.fill: parent
        onClicked:{ root.ListView.view.currentIndex = index }
    }
}





