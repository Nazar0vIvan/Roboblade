qt_add_library(qml_lib STATIC)

find_package(Qt6 REQUIRED COMPONENTS Quick)

qt_add_qml_module(qml_lib
    URI qml_lib
    VERSION 1.0
    QML_FILES 
        Main.qml
)

target_link_libraries(qml_lib
    PRIVATE Qt6::Quick
)
