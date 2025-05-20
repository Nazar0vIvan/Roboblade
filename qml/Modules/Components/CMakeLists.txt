find_package(Qt6 REQUIRED COMPONENTS Qml)

qt_add_library(componentsLib STATIC)

set_target_properties(componentsLib PROPERTIES AUTOMOC ON)
target_link_libraries(componentsLib PRIVATE Qt6::Qml)

qt_add_qml_module(componentsLib
    URI Modules.Components
    VERSION 1.0
    QML_FILES
        AppButton.qml
        AppComboBox.qml
        AppFileUpload.qml
        AppFormComponent.qml
        AppIcon.qml
        AppMenu.qml
        AppMenuBar.qml
        AppPopup.qml
        AppScrollBar.qml
        AppSwitch.qml
        AppTabButton.qml
        AppTextField.qml
        AppToolButton.qml
        LinearGradientModel.qml
        NavigationMenu.qml
        NavigationMenuDelegate.qml
)
