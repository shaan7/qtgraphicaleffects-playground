import QtQuick 2.9
import QtQuick.Controls 2.2

Slider {
    id: root
    property alias property: binding.property
    property alias effect: binding.target
    value: 0.5

    Binding {
        id: binding
        value: root.value
    }
}
