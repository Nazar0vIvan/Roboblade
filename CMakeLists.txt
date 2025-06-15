cmake_minimum_required(VERSION 3.16)

project(Roboblade VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Core Gui Qml Xml Quick)

#set(QML_IMPORT_PATH ${CMAKE_BINARY_DIR}/qml CACHE STRING "" FORCE)

add_subdirectory(qml)
add_subdirectory(src)







