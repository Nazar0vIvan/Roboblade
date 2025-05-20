import QtQuick 2.12
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.2

import AppStyles 1.0
import Properties 1.0

ObjectModel{
  id: root

  property var wgt

  function setWidget(wgt){ root.wgt = wgt }

  // the initial properties, that every widget has
  PropertiesSection{
    id: geometryPropsSection

    titleName: qsTr("Geometry")
    isSeparator: false
    properties:[ GeometryProperty{ id: geometryProp }]

  }

  onWgtChanged:{
    geometryProp.setWidget(wgt)
  }
}

