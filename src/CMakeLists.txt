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

qt_add_executable(roboblade_target
  main.cpp
  #${SOURCES}
  #${HEADERS}
)

qt_add_qml_module(roboblade_target
    URI roboblade
    VERSION 1.0
    NO_PLUGIN
    QML_FILES
      qml/Main.qml
      qml/Modules/Styles/Styles.qml
    RESOURCES
      qml/Modules/Styles/qmldir
)

target_link_libraries(roboblade_target
    PRIVATE Qt6::Core
    PRIVATE Qt6::Gui
    PRIVATE Qt6::Qml
    PRIVATE Qt6::Xml
    PRIVATE Qt6::Quick
)

target_compile_definitions(roboblade_target PRIVATE BINARY_PATH="${CMAKE_BINARY_DIR}")

include(GNUInstallDirs)
install(TARGETS roboblade_target
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
