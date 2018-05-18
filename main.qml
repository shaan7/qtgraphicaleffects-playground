import QtQuick 2.10
import QtQuick.Controls 2.2
import QtQuick.Controls.Universal 2.2
import QtQuick.Layouts 1.3
import QtQuick.Window 2.10
import QtGraphicalEffects 1.0
import QtQuick.Dialogs 1.2

ApplicationWindow {
    id: window
    visible: true
    width: 1000
    height: 700
    color: "black"
    title: qsTr("Qt Graphical Effects Playground")

    Components {
        id: components
    }

    EffectNamesModel {
        id: effectsModel
    }

    RowLayout {
        anchors.fill: parent

        Item {
            Layout.preferredWidth: parent.width * 0.2
            Layout.fillHeight: true

            ListView {
                anchors.fill: parent
                anchors.margins: 10

                spacing: 5
                interactive: false
                header: Label {
                    anchors.horizontalCenter: parent.horizontalCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.capitalization: Font.AllUppercase
                    text: "Effects"
                }

                model: effectsModel
                delegate: ItemDelegate {
                    width: ListView.view.width
                    height: 40

                    Label {
                        anchors.fill: parent
                        anchors.leftMargin: 10
                        anchors.rightMargin: 10

                        verticalAlignment: Text.AlignVCenter
                        text: name
                    }

                    onClicked: {
                        var properties = {
                            name: name,
                            prevEffect: imageItem.children[imageItem.children.length - 1]
                        }
                        components.effectComponents[index].createObject(imageItem, properties)
                    }
                }
            }
        }

        Rectangle {
            Layout.fillHeight: true
            Layout.preferredWidth: 1
            opacity: 0.2
            color: Universal.foreground
        }

        Item {
            id: imageItem
            Layout.fillWidth: true
            Layout.fillHeight: true

            Image {
                id: image
                property string name: "Image"
                anchors.fill: parent

                fillMode: Image.PreserveAspectFit
                source: "image.png"
            }

            function visibleEffect(beforeIndex) {
                for (var i=beforeIndex-1; i>0; i--) {
                    if (children[i].visible) {
                        return children[i];
                    }
                }

                return image;
            }
        }

        Rectangle {
            Layout.fillHeight: true
            Layout.preferredWidth: 1
            opacity: 0.2
            color: Universal.foreground
        }

        Item {
            Layout.preferredWidth: parent.width * 0.3
            Layout.fillHeight: true

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 10

                ListView {
                    id: appliedEffectsList
                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    clip: true
                    spacing: 5
                    header: Label {
                        anchors.horizontalCenter: parent.horizontalCenter
                        font.capitalization: Font.AllUppercase
                        text: "Applied"
                    }
                    headerPositioning: ListView.PullBackHeader

                    model: imageItem.children
                    delegate: RadioDelegate {
                        id: delegateRoot
                        property var item: null

                        width: ListView.view.width
                        enabled: index > 0
                        text: imageItem.children[index].name ? imageItem.children[index].name  : ""

                        Binding {
                            target: appliedEffectsList
                            property: "currentIndex"
                            value: index
                            when: delegateRoot.checked
                        }

                        Behavior on height {
                            NumberAnimation {
                                duration: 300
                                easing.type: Easing.OutQuint
                            }
                        }

                        ToolTip.text: "Source: " + imageItem.children[index].source.name
                        ToolTip.visible: hovered
                    }

                    ScrollBar.vertical: ScrollBar {}
                }

                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 1
                    color: Universal.foreground
                    opacity: 0.2
                    visible: settingsLoader.status === Loader.Ready
                }

                Loader {
                    id: settingsLoader
                    Layout.fillWidth: true
                    Layout.maximumWidth: parent.width
                    sourceComponent: imageItem.children[appliedEffectsList.currentIndex].settings
                }
            }
        }
    }

    TextArea {
        id: codeTextArea
        visible: false
        readOnly: true

        function populate() {
            var code = "";
            for (var i = 1; i < imageItem.children.length; i++) {
                code += imageItem.children[i].name + " { ";
                for (var j in imageItem.children[i].settingsDesc) {
                    var name = imageItem.children[i].settingsDesc[j].split(",")[0];
                    code += name + ": " + imageItem.children[i][name] + "; "
                }
                code += " }\n";
            }

            text = code;
        }
    }

    footer: Item {
        height: rowLayout.implicitHeight*1.2

        RowLayout {
            id: rowLayout
            anchors.centerIn: parent

            Button {
                Layout.fillHeight: true
                text: "Open"
                onClicked: fileDialog.open()

                FileDialog {
                    id: fileDialog

                    folder: shortcuts.pictures
                    onAccepted: image.source = fileUrl
                }
            }
            Button {
                Layout.fillHeight: true
                text: "Copy Code"
                onClicked: {
                    codeTextArea.populate();
                    codeTextArea.selectAll();
                    codeTextArea.copy();
                }
            }
        }

        Rectangle {
            anchors {
                left: parent.left; right: parent.right
                top: parent.top
            }
            height: 1
            color: Universal.foreground
            opacity: 0.2
        }
    }
}
