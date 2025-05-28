cmake_minimum_required(VERSION 3.16)

project(Roboblade VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)


find_package(Qt6 REQUIRED COMPONENTS Core Gui Qml Xml)

qt_standard_project_setup(REQUIRES 6.5)

list(APPEND QML_DIRS ${CMAKE_BINARY_DIR}/qml)
list(APPEND QML_DIRS ${CMAKE_BINARY_DIR}/qml/Modules/Components)
list(APPEND QML_DIRS ${CMAKE_BINARY_DIR}/qml/Modules/Styles)
list(APPEND QML_DIRS ${CMAKE_BINARY_DIR}/qml/Modules/Widget)
set(QML_IMPORT_PATH ${QML_DIRS} CACHE STRING "" FORCE)

add_subdirectory(qml)
add_subdirectory(src)






