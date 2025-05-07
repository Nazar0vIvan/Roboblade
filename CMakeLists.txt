cmake_minimum_required(VERSION 3.16)

project(Roboblade VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTOMOC ON)

add_subdirectory(src)
add_subdirectory(qml_lib)

