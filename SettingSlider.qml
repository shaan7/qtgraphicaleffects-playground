import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

Slider {
    id: root
    property alias property: binding.property
    property alias effect: binding.target
    Layout.fillWidth: true

    value: 0.5

    Binding {
        id: binding
        value: root.value
    }
}
