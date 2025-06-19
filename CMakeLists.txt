cmake_minimum_required(VERSION 3.16)

project(Roboblade VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Core Gui Qml Xml Quick)

# With ver. 6.5 RESOURCE_PREFIX for qml modules is ":/qt/qml/"
qt_standard_project_setup(REQUIRES 6.5)


## ASSETS ##

# set(FONTS
#   ./assets/fonts/nasalization/Nasalization-Regular.ttf
#   ../assets/fonts/opensans/OpenSans-Bold.ttf
#   ../assets/fonts/opensans/OpenSans-Italic.ttf
#   ../assets/fonts/opensans/OpenSans-Regular.ttf
#   ../assets/fonts/roboto/Roboto-Bold.ttf
#   ../assets/fonts/roboto/Roboto-Medium.ttf
#   ../assets/fonts/roboto/Roboto-Regular.ttf
# )

#set(ICONS
  #${CMAKE_CURRENT_SOURCE_DIR}/assets/icons/logo.svg
  # ../assets/icons/dashboard/adjust.svg
  # ../assets/icons/dashboard/arrow_down.svg
  # ../assets/icons/dashboard/arrow_left.png
  # ../assets/icons/dashboard/arrow_right.svg
  # ../assets/icons/dashboard/bar_chart.svg
  # ../assets/icons/dashboard/fullscreen.svg
  # ../assets/icons/dashboard/gauge.svg
  # ../assets/icons/dashboard/grid.svg
  # ../assets/icons/dashboard/group.svg
  # ../assets/icons/dashboard/line_chart.svg
  # ../assets/icons/dashboard/line_width.svg
  # ../assets/icons/dashboard/numeric.svg
  # ../assets/icons/dashboard/pie_chart.svg
  # ../assets/icons/dashboard/radius.svg
  # ../assets/icons/dashboard/search.svg
  # ../assets/icons/dashboard/settings.svg
  # ../assets/icons/dashboard/snap.svg
  # ../assets/icons/dashboard/table.svg
  # ../assets/icons/dashboard/text.svg
  # ../assets/icons/dashboard/tick.svg
  # ../assets/icons/dashboard/vfd.svg
  # ../assets/icons/menu/open.svg
  # ../assets/icons/menu/play.svg
  # ../assets/icons/menu/power.svg
  # ../assets/icons/menu/redo.svg
  # ../assets/icons/menu/save.svg
  # ../assets/icons/menu/save_as.svg
  # ../assets/icons/menu/stop.svg
  # ../assets/icons/menu/timer.svg
  # ../assets/icons/menu/undo.svg
  # ../assets/icons/navigation/dashboard.svg
  # ../assets/icons/navigation/help.svg
  # ../assets/icons/navigation/model.svg
  # ../assets/icons/navigation/network.svg
  # ../assets/icons/navigation/scene.svg
  # ../assets/icons/navigation/settings.svg
#)

add_subdirectory(src)







