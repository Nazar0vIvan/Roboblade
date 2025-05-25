qt_add_executable(app
  main.cpp
)

target_link_libraries(app
    PRIVATE Qt6::Core
    PRIVATE Qt6::Gui
    PRIVATE Qt6::Qml
    PRIVATE qml
    PRIVATE components
)

install(TARGETS app
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
