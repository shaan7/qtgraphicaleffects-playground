import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.3

Button {
    id: root
    property alias property: binding.property
    property alias effect: binding.target
    property alias color: dialog.color

    Layout.fillWidth: true
    text: "Choose Color    "

    ColorDialog {
        id: dialog
    }

    Binding {
        id: binding
        value: dialog.visible ? dialog.currentColor : dialog.color
    }

    Rectangle {
        anchors {
            top: parent.top
            bottom: parent.bottom
            right: parent.right
            margins: 2
        }
        width: height
        color: dialog.color
    }

    onClicked: {
        dialog.currentColor = color;
        dialog.open();
    }
}
