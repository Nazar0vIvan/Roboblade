.pragma library
.import QtQml 2.12 as QML

var component;
var widget

function createWidget(widgetType, flick = null, serial = 0, x = 0, y = 0) {
    switch(widgetType){
        case 8: // default
            component = Qt.createComponent("DashboardWidget.qml"); break
        case 0: // numeric
            component = Qt.createComponent("NumericWidget.qml"); break
        case 1: // gauge
            component = Qt.createComponent("GaugeWidget.qml"); break
        case 3: // line_chart
            component = Qt.createComponent("LineChartWidget.qml"); break
	}
    if (component.status === QML.Component.Ready)
        return finishCreation(component, widgetType, flick, serial, x , y)
	else
		component.statusChanged.connect(finishCreation);
}

function finishCreation(component, widgetType, flick, serial, x, y){
    if (component.status === QML.Component.Ready) {
        return component.createObject(flick.contentItem, { type: widgetType, serial: serial, flick: flick, x: x, y: y })
	}
    else if (component.status === QML.Component.Error) {
		console.log("Error loading component:", component.errorString());
	}
}
