qt_add_qml_module(components
    URI qml.Modules.Components
    VERSION 1.0
    NO_PLUGIN
    QML_FILES
        AppRectangle.qml
        AppButton.qml
        AppFileUpload.qml
        AppFormComponent.qml
        AppComboBox.qml
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

