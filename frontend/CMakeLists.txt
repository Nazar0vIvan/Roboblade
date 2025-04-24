find_package(Qt6 REQUIRED COMPONENTS Quick)

qt_add_qml_module(qml
    URI qml
    VERSION 1.0
    QML_FILES 
    	qml/Main.qml
        qml/Components/AppMenuBar.qml
        qml/Components/AppMenu.qml
        qml/Styles/Styles.qml
)

target_link_libraries(qml
    PRIVATE Qt6::Quick
)
