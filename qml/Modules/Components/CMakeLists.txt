qt_add_qml_module(components
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

target_link_libraries(components PRIVATE Qt6::Qml)
