find_package(Qt6 REQUIRED COMPONENTS Core Gui Qml)

qt_add_executable(app
  main.cpp
)

target_link_libraries(app
    PRIVATE Qt6::Core
    PRIVATE Qt6::Gui
    PRIVATE Qt6::Qml
)

qt_add_qml_module(app
  URI qml
  VERSION 1.0
  RESOURCES resources.qrc
)

install(TARGETS app
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
