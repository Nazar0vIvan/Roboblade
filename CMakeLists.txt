cmake_minimum_required(VERSION 3.16)

project(Roboblade VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Core Gui Qml Xml Quick)

# With ver. 6.5 RESOURCE_PREFIX for qml modules is ":/qt/qml/"
qt_standard_project_setup(REQUIRES 6.5)

add_subdirectory(src)







