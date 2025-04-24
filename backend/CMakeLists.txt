find_package(Qt6 REQUIRED COMPONENTS Core)

qt_add_executable(src
  main.cpp
  logger.h
  logger.cpp
)

target_link_libraries(src
    PRIVATE Qt6::Core
)
