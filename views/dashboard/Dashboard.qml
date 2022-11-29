import QtQuick 2.12
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.2
import QtQml.Models 2.15

import AppStyle 1.0
import Widgets 1.0

import "sidePanel"

Item{
    id: root

    RowLayout{
        id: rootRL

        anchors{ fill: parent; topMargin: 2 } // !!!!
        spacing: 1

        ColumnLayout{
            id: rootCL

            Layout.fillWidth: true; Layout.fillHeight: true;
            spacing: 1

            DashboardToolBar{
                id: dbToolBar

                Layout.fillWidth: true; Layout.preferredHeight: 45
                color: AppStyle.background
            }

            DashboardScene{
                id: dbScene

                Layout.fillWidth: true; Layout.fillHeight: true
                color: AppStyle.background
            }
        }

        DashboardSidePanel{
            id: dbSidePanel

            Layout.preferredWidth: AppStyle.drawerWidth; Layout.fillHeight: true
            color: AppStyle.background
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

        dbSidePanel.subsDrawerStateChanged.connect(dbScene.subsDrawerStateChanged)
    }
}

