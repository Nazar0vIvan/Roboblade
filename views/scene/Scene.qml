import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.15
import Qt.labs.settings 1.0

import AppStyle 1.0
import Components 1.0

Rectangle{
    id: root

    color: AppStyle.background

    ListView{
        id: lv

        anchors{ fill: parent; margins: 10 }
        model: ["3D", "RSI on/off"]

        delegate: Text{
            color: AppStyle.foreground
            text: modelData
        }
    }
}


