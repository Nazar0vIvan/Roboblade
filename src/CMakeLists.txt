# set(SOURCES
#   logger.cpp
#   socket.cpp
#   sockethou.cpp
#   socketmodbustcp.cpp
#   socketrdt.cpp
#   socketrsi.cpp
# )

# set(HEADERS
#   logger.h
#   socket.h
#   sockethou.h
#   socketmodbustcp.h
#   socketrdt.h
#   socketrsi.h
# )

set(QML_FILES
  qml/Main.qml
  qml/Logger.qml
  qml/Views/Dashboard/Dashboard.qml
  qml/Views/Dashboard/DashboardScene.qml
  qml/Views/Dashboard/DashboardToolBar.qml
  qml/Views/Dashboard/SidePanel/BasePropsModel.qml
  qml/Views/Dashboard/SidePanel/DashboardSidePanel.qml
  qml/Views/Dashboard/SidePanel/PropsTab.qml
  qml/Views/Dashboard/SidePanel/SubsTab.qml
  qml/Views/Dashboard/SidePanel/SubsDrawer/SubsDrawer.qml
  qml/Views/Dashboard/SidePanel/SubsDrawer/SubsTable.qml
  qml/Views/Dashboard/SidePanel/SubsDrawer/SubsTableCheckDelegate.qml
  qml/Views/Dashboard/SidePanel/SubsDrawer/SubsTableHeaderDelegate.qml
  qml/Views/Dashboard/SidePanel/SubsDrawer/SubsTableItemDelegate.qml
  qml/Views/Network/Network.qml
  qml/Views/Network/NetworkTable.qml
  qml/Views/Network/NetworkTableItemDelegate.qml
  qml/Navigation/Logo.qml
  qml/Navigation/NavigationPanel.qml
  #qml/Navigation/NavigationMenu.qml
  #qml/Navigation/NavigationMenuDelegate.qml
)

set(QML_FILES_STYLES
  qml/Modules/Styles/Styles.qml
)

set(QML_FILES_COMPONENTS
  qml/Modules/Components/QxButton.qml
  qml/Modules/Components/QxComboBox.qml
  qml/Modules/Components/QxFileUpload.qml
  qml/Modules/Components/QxFormComponent.qml
  qml/Modules/Components/QxIcon.qml
  qml/Modules/Components/QxLinearGradientModel.qml
  qml/Modules/Components/QxMenu.qml
  qml/Modules/Components/QxMenuBar.qml
  qml/Modules/Components/QxNavigationMenu.qml
  qml/Modules/Components/QxNavigationMenuDelegate.qml
  qml/Modules/Components/QxPopup.qml
  qml/Modules/Components/QxScrollBar.qml
  qml/Modules/Components/QxSwitch.qml
  qml/Modules/Components/QxTabButton.qml
  qml/Modules/Components/QxTextField.qml
  qml/Modules/Components/QxToolButton.qml
)

set(QML_FILES_WIDGETS
  qml/Modules/Widgets/DashboardWidget.qml
  qml/Modules/Widgets/GaugeWidget.qml
  qml/Modules/Widgets/LineChartWidget.qml
  qml/Modules/Widgets/NumericWidget.qml
  qml/Modules/Widgets/WidgetFactory.js
)

set(QML_FILES_PROPERTIES
  qml/Modules/Properties/BorderProperty.qml
  qml/Modules/Properties/ColorProperty.qml
  qml/Modules/Properties/GeometryProperty.qml
  qml/Modules/Properties/LineProperty.qml
  qml/Modules/Properties/PropertiesSection.qml
  qml/Modules/Properties/TextProperty.qml
)

set(QML_FILES_QMLDIRS
  qml/Modules/Styles/qmldir
  qml/Modules/Components/qmldir
  qml/Modules/Widgets/qmldir
  qml/Modules/Properties/qmldir
)

qt_add_executable(roboblade
  main.cpp
  #${SOURCES}
  #${HEADERS}
)

list(APPEND QML_IMPORT_DIRS ${CMAKE_BINARY_DIR}/src/roboblade_qml_module)
set(QML_IMPORT_PATH ${QML_IMPORT_DIRS} CACHE STRING "" FORCE)

qt_add_qml_module(roboblade
    URI roboblade_qml_module
    VERSION 1.0
    NO_PLUGIN
    QML_FILES
      ${QML_FILES}
      ${QML_FILES_STYLES}
      ${QML_FILES_COMPONENTS}
      ${QML_FILES_WIDGETS}
      ${QML_FILES_PROPERTIES}
    RESOURCES
      ${QML_FILES_QMLDIRS}
)

target_link_libraries(roboblade
    PRIVATE Qt6::Core
    PRIVATE Qt6::Gui
    PRIVATE Qt6::Qml
    PRIVATE Qt6::Xml
    PRIVATE Qt6::Quick
)

target_compile_definitions(roboblade PRIVATE BINARY_PATH="${CMAKE_BINARY_DIR}")

include(GNUInstallDirs)

install(TARGETS roboblade
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
