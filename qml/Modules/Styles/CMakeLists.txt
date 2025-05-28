qt_add_qml_module(styles
    URI Modules.Styles
    VERSION 1.0
    NO_PLUGIN
    QML_FILES
        Styles.qml
)

set_source_files_properties(Styles.qml PROPERTIES QT_QML_SINGLETON_TYPE TRUE)

target_link_libraries(styles PRIVATE Qt6::Qml)
