set_source_files_properties(MyStyles.qml PROPERTIES QT_QML_SINGLETON_TYPE TRUE)

qt_add_qml_module(styles
    URI Modules.Styles
    VERSION 1.0
    NO_PLUGIN
    OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/qml/Modules/Styles
    QML_FILES
        MyStyles.qml
)

target_link_libraries(styles PRIVATE Qt6::Qml)
