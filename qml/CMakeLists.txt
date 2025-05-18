find_package(Qt6 REQUIRED COMPONENTS Qml)

qt_add_qml_module(qml
    URI qml
    VERSION 1.0
    QML_FILES
        Main.qml
)

set_target_properties(qml PROPERTIES
    QML_IMPORT_PATH "${CMAKE_SOURCE_DIR}/qml"
)

target_link_libraries(qml
    PRIVATE Qt6::Qml
)
