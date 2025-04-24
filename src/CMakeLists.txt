cmake_minimum_required(VERSION 3.16)

# qt_add_library(Source STATIC)

# set_target_properties(Source PROPERTIES AUTOMOC ON)
# find_package(Qt6 REQUIRED COMPONENTS Core)

qt_add_executable(Source
  main.cpp
  logger.h
	logger.cpp
)
