qt_add_qml_module(widgets
    URI Modules.Widgets
    VERSION 1.0
    NO_PLUGIN
    QML_FILES 
        DashboardWidget.qml
        GaugeWidget.qml
        LineChartWidget.qml
        NumericWidget.qml
        WidgetFactory.js
)

target_link_libraries(widgets PRIVATE Qt6::Qml)
