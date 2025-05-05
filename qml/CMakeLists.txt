find_package(Qt6 REQUIRED COMPONENTS Quick)

qt_add_qml_module(frontend
    URI frontend
    VERSION 1.0
    QML_FILES 
        Main.qml
)

target_link_libraries(frontend
    PRIVATE Qt6::Quick
)
