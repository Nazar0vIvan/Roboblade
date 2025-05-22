import QtQuick 2.12
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.2
import QtQml.Models 2.15

import AppStyles 1.0
import Widgets 1.0

import "sidePanel"

Item{
  id: root

  RowLayout{
    id: rootRL

    anchors{ fill: parent; topMargin: 1 } // !!!!
    spacing: 1

    ColumnLayout{
      id: rootCL

      Layout.fillWidth: true; Layout.fillHeight: true;
      spacing: 1

      DashboardToolBar{
        id: dbToolBar

        Layout.fillWidth: true; Layout.preferredHeight: 45
        color: Styles.background.dp00
      }

      DashboardScene{
        id: dbScene

        Layout.fillWidth: true; Layout.fillHeight: true
        color: Styles.background.dp00
      }
    }

    DashboardSidePanel{
      id: dbSidePanel

      Layout.preferredWidth: Styles.drawerWidth; Layout.fillHeight: true
      color: Styles.background.dp00
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

    dbScene.selectionChanged.connect(dbSidePanel.selectionChanged)
  }
}

