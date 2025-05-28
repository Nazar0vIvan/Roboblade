set(SOURCES
  logger.cpp
  socket.cpp
  sockethou.cpp
  socketmodbustcp.cpp
  socketrdt.cpp
  socketrsi.cpp
)

set(HEADERS
  logger.h
  socket.h
  sockethou.h
  socketmodbustcp.h
  socketrdt.h
  socketrsi.h
)

qt_add_executable(app
  main.cpp
  ${SOURCES}
  ${HEADERS}
)

target_link_libraries(app
    PRIVATE Qt6::Core
    PRIVATE Qt6::Gui
    PRIVATE Qt6::Qml
    PRIVATE Qt6::Xml
    PRIVATE qml
    PRIVATE components
    PRIVATE styles
)

include(GNUInstallDirs)
install(TARGETS app
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
