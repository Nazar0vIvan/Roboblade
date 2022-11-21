import QtQuick 2.12
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.2

import AppStyle 1.0

Item{
    id: root

    required property string fieldName
    property alias fieldText: textField.text
    property alias fieldDefaultText: defaultText.text
    property alias validator: textField.validator
    property alias background: backgroundRect.color
    property alias readOnly: textField.readOnly
    property int nameWidth: 65

    RowLayout{
        id: fieldLayout

        anchors.fill: parent

        Label{
            Layout.preferredWidth: nameWidth; Layout.preferredHeight: fieldLayout.height
            verticalAlignment: Text.AlignVCenter
            text: root.fieldName
            color: AppStyle.settingsWindow.network.color
            font: AppStyle.settingsWindow.network.font
        }

        TextField{
            id: textField

            Layout.fillWidth: true; Layout.preferredHeight: fieldLayout.height
            Layout.alignment: Qt.AlignVCenter

            background: Rectangle{
                    id: backgroundRect
                    color: AppStyle.settingsWindow.network.background
                    border{color: "gray"; width: 1}
            }
            verticalAlignment: TextInput.AlignVCenter
            leftPadding: 5
            text: root.fieldText
            font: AppStyle.settingsWindow.network.font
            color: AppStyle.settingsWindow.network.color
            selectionColor: AppStyle.settingsWindow.network.selected
            activeFocusOnPress: true
            selectByMouse: true
            Text {
                id: defaultText

                anchors.fill: parent
                verticalAlignment: Text.AlignVCenter
                leftPadding: 5
                color: "white"
                visible: !textField.text
                font.italic: true
            }
        }
    }
}
