cmake_minimum_required(VERSION 3.16)

project(qml_module_cmake VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTOMOC ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_resources(APP_ICONS "icons.qrc")

qt_add_executable(app_qml_module_cmake
    main.cpp
    ${APP_ICONS}
)

qt_add_qml_module(app_qml_module_cmake
    URI "qml_module_cmake"
    VERSION 1.0
    QML_FILES Main.qml
)

add_subdirectory(Styles)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(app_qml_module_cmake PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.app_qml_module_cmake
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(app_qml_module_cmake
    PRIVATE Qt6::Quick StylesLibplugin
)

include(GNUInstallDirs)
install(TARGETS app_qml_module_cmake
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
