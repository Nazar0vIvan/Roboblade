find_package(Qt6 REQUIRED COMPONENTS Core Gui Qml)

qt_add_executable(src
  main.cpp
)

target_link_libraries(src
    PRIVATE Qt6::Core
    PRIVATE Qt6::Gui
    PRIVATE Qt6::Qml
    frontend
)

install(TARGETS src
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
