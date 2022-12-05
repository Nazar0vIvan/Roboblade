import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.2
import Qt5Compat.GraphicalEffects

import AppStyle 1.0

Item{
    id: root

    property alias source: icon.source
    property bool isMasked: mask.visible
    property color color: AppStyle.foreground

    Image{
        id: icon

        anchors.fill: parent
        fillMode: Image.PreserveAspectFit
        smooth: true
        mipmap: true
        visible: false
    }
    Rectangle{
        id: colorRect

        anchors.fill: parent
        color: root.color
        visible: false
        antialiasing: true
    }
    OpacityMask{
        id: mask

        anchors.fill: parent
        source: colorRect
        maskSource: icon
    }
}
