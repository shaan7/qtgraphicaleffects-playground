import QtQuick 2.9
import QtQuick.Controls 2.2

CheckBox {
    id: root
    property alias property: binding.property
    property alias effect: binding.target

    Binding {
        id: binding
        value: root.checked
    }
}
