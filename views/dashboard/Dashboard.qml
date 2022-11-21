import QtQuick 2.12
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.2
import QtQml.Models 2.15

import AppStyle 1.0
import Widgets 1.0

import "sidePanel"

Rectangle{
    id: root

    color: AppStyle.surface

    ColumnLayout{
        id: columnLayout

        anchors.fill: parent
        spacing: 5

        DashboardToolBar{
            id: dbToolBar

            Layout.fillWidth: true; Layout.preferredHeight: 70
            color: AppStyle.background
        }
        RowLayout{
            id: rowLayout

            Layout.fillWidth: true; Layout.fillHeight: true

            DashboardScene{
                id: dbScene

                Layout.fillWidth: true; Layout.fillHeight: true
                color: AppStyle.background
            }

            DashboardSidePanel{
                id: dbSidePanel

                Layout.preferredWidth: AppStyle.drawerWidth; Layout.fillHeight: true
                color: AppStyle.background
            }
        }
    }

    Component.onCompleted: {
        dbToolBar.grid.connect(dbScene.slotGrid)
        dbToolBar.snap.connect(dbScene.slotSnap)

        dbToolBar.gridStepChanged.connect(dbScene.slotGridStepChanged)
        dbToolBar.gridLineTypeChanged.connect(dbScene.slotGridLineTypeChanged)
        dbToolBar.gridLineColorChanged.connect(dbScene.slotGridLineColorChanged)
        dbToolBar.gridLineWidthChanged.connect(dbScene.slotGridWidthChanged)
        dbToolBar.gridOpacityChanged.connect(dbScene.slotGridOpacityChanged)
        dbToolBar.snapSpacingChanged.connect(dbScene.slotSnapSpacingChanged)

        dbScene.selectionChanged.connect(dbSidePanel.slotSelectionChanged)

        dbSidePanel.subsPopupStateChanged.connect(dbScene.subsPopupStateChanged)
    }
}

