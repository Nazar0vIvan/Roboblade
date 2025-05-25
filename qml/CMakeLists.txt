qt_add_qml_module(qml
    URI qml
    VERSION 1.0
    QML_FILES
        Main.qml
        Views/Dashboard/Dashboard.qml
        Views/Dashboard/DashboardScene.qml
        Views/Dashboard/DashboardToolBar.qml
        Views/Dashboard/SidePanel/BasePropsModel.qml
        Views/Dashboard/SidePanel/DashboardSidePanel.qml
        Views/Dashboard/SidePanel/PropsTab.qml
        Views/Dashboard/SidePanel/SubsTab.qml
        Views/Dashboard/SidePanel/SubsDrawer/SubsDrawer.qml
        Views/Dashboard/SidePanel/SubsDrawer/SubsTable.qml
        Views/Dashboard/SidePanel/SubsDrawer/SubsTableCheckDelegate.qml
        Views/Dashboard/SidePanel/SubsDrawer/SubsTableHeaderDelegate.qml
        Views/Dashboard/SidePanel/SubsDrawer/SubsTableItemDelegate.qml
        Views/Network/Network.qml
        Views/Network/NetworkTable.qml
        Views/Network/NetworkTableItemDelegate.qml
        Navigation/Logo.qml
        Navigation/NavigationMenu.qml
        Navigation/NavigationMenuDelegate.qml
        Navigation/NavigationPanel.qml
)

add_subdirectory(Modules/Components)

target_link_libraries(qml PRIVATE Qt6::Qml)
