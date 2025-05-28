qt_add_qml_module(qml
    URI qml
    VERSION 1.0
    NO_PLUGIN
    QML_FILES
        Main.qml
        Logger.qml
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
        Properties/BorderProperty.qml
        Properties/ColorProperty.qml
        Properties/GeometryProperty.qml
        Properties/LineProperty.qml
        Properties/PropertiesSection.qml
        Properties/TextProperty.qml
)

add_subdirectory(Modules/Components)
add_subdirectory(Modules/Styles)
add_subdirectory(Modules/Widgets)

target_link_libraries(qml PRIVATE Qt6::Qml)
