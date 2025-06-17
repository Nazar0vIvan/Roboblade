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

qt_add_executable(roboblade
  main.cpp
  #${SOURCES}
  #${HEADERS}
)

set(QML_IMPORT_PATH ${CMAKE_BINARY_DIR}/src/roboblade_qml_module CACHE STRING "" FORCE)

qt_add_qml_module(roboblade
    URI roboblade_qml_module
    VERSION 1.0
    NO_PLUGIN
    QML_FILES
      qml/Main.qml
      qml/Modules/Styles/Styles.qml
    RESOURCES
      qml/Modules/Styles/qmldir
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
