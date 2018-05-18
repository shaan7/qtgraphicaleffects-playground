import QtQuick 2.10
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Window 2.10
import QtGraphicalEffects 1.0

Window {
    id: window
    visible: true
    width: 900
    height: 600
    color: "black"
    title: qsTr("Hello World")

    Components {
        id: components
    }

    ListModel {
        id: effectsModel

        ListElement {
            name: "BrightnessContrast"
        }
        ListElement {
            name: "ColorOverlay"
        }
        ListElement {
            name: "Colorize"
        }
        ListElement {
            name: "Desaturate"
        }
        ListElement {
            name: "GammaAdjust"
        }
        ListElement {
            name: "HueSaturation"
        }
        ListElement {
            name: "LevelAdjust"
        }
    }

    RowLayout {
        anchors.fill: parent

        Item {
            Layout.preferredWidth: parent.width * 0.3
            Layout.fillHeight: true

            ListView {
                anchors.fill: parent

                model: effectsModel
                delegate: ItemDelegate {
                    width: ListView.view.width
                    height: 32

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
                            source: imageItem.children[imageItem.children.length - 1]
                        }
                        components.effectComponents[index].createObject(imageItem, properties)
                    }
                }
            }
        }

        Item {
            id: imageItem
            Layout.fillWidth: true
            Layout.fillHeight: true

            Image {
                id: image
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

        Item {
            Layout.preferredWidth: parent.width * 0.3
            Layout.fillHeight: true

            ColumnLayout {
                anchors.fill: parent

                ListView {
                    id: appliedEffectsList
                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    spacing: 5
                    model: imageItem.children
                    delegate: RadioDelegate {
                        id: delegateRoot
                        property var item: null

                        visible: text !== ""
                        width: ListView.view.width

                        text: imageItem.children[index].name ? imageItem.children[index].name : ""

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
                    }
                }

                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 2
                    color: "black"
                }

                Loader {
                    sourceComponent: imageItem.children[appliedEffectsList.currentIndex].settings
                }

                //                        Slider {
                //                            id: slider

                //                            Binding {
                //                                target: imageItem.children[appliedEffectsList.currentIndex]
                //                                property: imageItem.children[appliedEffectsList.currentIndex].properties[index]
                //                                value: slider.value
                //                                when: slider.pressed
                //                            }
                //                            Binding {
                //                                target: slider
                //                                property: "value"
                //                                value: imageItem.children[appliedEffectsList.currentIndex][imageItem.children[appliedEffectsList.currentIndex].properties[index]]
                //                                when: !slider.pressed
                //                            }
                //                        }
            }
        }
    }
}
