qt_add_qml_module(components
    URI Modules.Components
    VERSION 1.0
    OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/qml/Modules/Components
    QML_FILES
        Components/AppButton.qml
        Components/AppFileUpload.qml
        Components/AppFormComponent.qml
        Components/AppComboBox.qml
        Components/AppIcon.qml
        Components/AppMenu.qml
        Components/AppMenuBar.qml
        Components/AppPopup.qml
        Components/AppScrollBar.qml
        Components/AppSwitch.qml
        Components/AppTabButton.qml
        Components/AppTextField.qml
        Components/AppToolButton.qml
        Components/LinearGradientModel.qml
        Components/NavigationMenu.qml
        Components/NavigationMenuDelegate.qml
)

target_link_libraries(components PRIVATE Qt6::Qml)

# --------------------------------------------------------------------------
qt_add_qml_module(styles
    URI Modules.Styles
    VERSION 1.0
    OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/qml/Modules/Styles
    QML_FILES
	Styles/Styles.qml
)

set_source_files_properties(Styles.qml PROPERTIES QT_QML_SINGLETON_TYPE TRUE)

target_link_libraries(styles PRIVATE Qt6::Qml)

# --------------------------------------------------------------------------
qt_add_qml_module(widgets
    URI Modules.Widgets
    VERSION 1.0
    OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/qml/Modules/Widgets
    QML_FILES 
        Widgets/DashboardWidget.qml
        Widgets/GaugeWidget.qml
        Widgets/LineChartWidget.qml
        Widgets/NumericWidget.qml
        Widgets/WidgetFactory.js
)

target_link_libraries(widgets PRIVATE Qt6::Qml)
