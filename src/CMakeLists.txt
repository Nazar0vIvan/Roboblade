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

qt_add_executable(app
  main.cpp
  #${SOURCES}
  #${HEADERS}
)

target_link_libraries(app
    PRIVATE Qt6::Core
    PRIVATE Qt6::Gui
    PRIVATE Qt6::Qml
    PRIVATE Qt6::Xml
    PRIVATE Qt6::Quick
    PRIVATE qmlModule
)

target_compile_definitions(app PRIVATE BINARY_PATH="${CMAKE_BINARY_DIR}")

include(GNUInstallDirs)
install(TARGETS app
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
