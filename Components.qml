import QtQuick 2.9
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.3

Item {
    property var effectComponents: ([brightnessContrastComponent, colorOverlayComponent, colorizeComponent, desaturateComponent, gammaAdjustComponent, hueSaturationComponent, levelAdjustComponent])

    Component {
        id: bindingComponent
        Binding {}
    }

    Component {
        id: settingLabelComponent
        SettingLabel {}
    }

    Component {
        id: settingSliderComponent
        SettingSlider {}
    }

    Component {
        id: settingColorDialogComponent
        SettingColorDialog {}
    }

    Component {
        id: settingCheckBoxComponent
        SettingCheckBox {}
    }

    function setupControls(effect, grid) {
        for (var i in effect.settingsDesc) {
            var name = effect.settingsDesc[i].split(",")[0];
            var type = effect.settingsDesc[i].split(",")[1];

            var item = settingLabelComponent.createObject(grid, {"text": name});

            var control;
            switch (type) {
            case "bool":
                control = settingCheckBoxComponent.createObject(grid, {"checked": effect[name]});
                control.property = name;
                control.effect = effect;
                break;
            case "real":
                control = settingSliderComponent.createObject(grid, {"value": effect[name]});
                control.property = name;
                control.effect = effect;
                break;
            case "color":
                control = settingColorDialogComponent.createObject(grid, {"color": effect[name]});
                control.property = name;
                control.effect = effect;
                break;
            }
        }
    }

    Component {
        id: brightnessContrastComponent

        BrightnessContrast {
            id: effect
            property string name
            property var prevEffect
            property var settingsDesc: (["visible,bool", "opacity,real", "brightness,real", "contrast,real"])
            property var settings: Component {
                GridLayout {
                    id: grid
                    columns: 2

                    Component.onCompleted: setupControls(effect, grid)
                }
            }

            anchors.fill: image
            source: prevEffect.visible ? prevEffect : prevEffect.source
        }
    }

    Component {
        id: colorOverlayComponent

        ColorOverlay {
            id: effect
            property string name
            property var prevEffect
            property var settingsDesc: (["visible,bool", "opacity,real", "color,color"])
            property var settings: Component {
                GridLayout {
                    id: grid
                    columns: 2

                    Component.onCompleted: setupControls(effect, grid)
                }
            }

            anchors.fill: image
            source: prevEffect.visible ? prevEffect : prevEffect.source
            color: "red"
            opacity: 0.1
        }
    }

    Component {
        id: colorizeComponent

        Colorize {
            id: effect
            property string name
            property var prevEffect
            property var settingsDesc: (["visible,bool", "opacity,real", "hue,real", "saturation,real", "lightness,real"])
            property var settings: Component {
                GridLayout {
                    id: grid
                    Layout.fillWidth: true
                    columns: 2

                    Component.onCompleted: setupControls(effect, grid)
                }
            }

            anchors.fill: image
            source: prevEffect.visible ? prevEffect : prevEffect.source
            hue: 0.0
            saturation: 0.5
            lightness: -0.2
        }
    }

    Component {
        id: desaturateComponent

        Desaturate {
            id: effect
            property string name
            property var prevEffect
            property var settingsDesc: (["visible,bool", "opacity,real", "desaturation,real"])
            property var settings: Component {
                GridLayout {
                    id: grid
                    Layout.fillWidth: true
                    columns: 2

                    Component.onCompleted: setupControls(effect, grid)
                }
            }

            anchors.fill: image
            source: prevEffect.visible ? prevEffect : prevEffect.source
            desaturation: 0.8
        }
    }

    Component {
        id: gammaAdjustComponent

        GammaAdjust {
            id: effect
            property string name
            property var prevEffect
            property var settingsDesc: (["visible,bool", "opacity,real", "gamma,real"])
            property var settings: Component {
                GridLayout {
                    id: grid
                    Layout.fillWidth: true
                    columns: 2

                    Component.onCompleted: setupControls(effect, grid)
                }
            }

            anchors.fill: image
            source: prevEffect.visible ? prevEffect : prevEffect.source
            gamma: 1.0
        }
    }

    Component {
        id: hueSaturationComponent

        HueSaturation {
            id: effect
            property string name
            property var prevEffect
            property var settingsDesc: (["visible,bool", "opacity,real", "hue,real", "saturation,real", "lightness,real"])
            property var settings: Component {
                GridLayout {
                    id: grid
                    Layout.fillWidth: true
                    columns: 2

                    Component.onCompleted: setupControls(effect, grid)
                }
            }

            anchors.fill: image
            source: prevEffect.visible ? prevEffect : prevEffect.source
            hue: -0.3
            saturation: 0.5
            lightness: -0.1
        }
    }

    Component {
        id: levelAdjustComponent

        LevelAdjust {
            id: effect
            property string name
            property var prevEffect
            property var settingsDesc: (["visible,bool", "opacity,real", "minimumInput,color", "minimumOutput,color", "maximumInput,color", "maximumOutput,color"])
            property var settings: Component {
                GridLayout {
                    id: grid
                    Layout.fillWidth: true
                    columns: 2

                    Component.onCompleted: setupControls(effect, grid)
                }
            }

            anchors.fill: image
            source: prevEffect.visible ? prevEffect : prevEffect.source
            minimumOutput: "#00ffffff"
            maximumOutput: "#ff000000"
        }
    }
}
