import QtQuick 2.9
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

Item {
    property var effectComponents: ([brightnessContrastComponent, colorOverlayComponent, colorizeComponent, desaturateComponent, gammaAdjustComponent, hueSaturationComponent, levelAdjustComponent])

    Component {
        id: brightnessContrastComponent

        BrightnessContrast {
            id: effect
            property string name
            property var settings: Component {
                ColumnLayout {
                    RowLayout {
                        Label {
                            text: "brightness"
                        }
                        Slider {
                            id: slider

                            Binding {
                                property: "brightness"
                                target: effect
                                value: slider.value
                            }
                        }
                    }
                }
            }

            anchors.fill: image
            source: image
        }
    }

    Component {
        id: colorOverlayComponent

        ColorOverlay {
            property string name

            anchors.fill: image
            source: image
            color: "#80800000"
        }
    }

    Component {
        id: colorizeComponent

        Colorize {
            property string name

            anchors.fill: image
            source: image
            hue: 0.0
            saturation: 0.5
            lightness: -0.2
        }
    }

    Component {
        id: desaturateComponent

        Desaturate {
            property string name
            property var properties: (["desaturation"])

            anchors.fill: image
            source: image
            desaturation: 0.8
        }
    }

    Component {
        id: gammaAdjustComponent

        GammaAdjust {
            property string name
            property var properties: (["gamma"])

            anchors.fill: image
            source: image
            gamma: 0.45
        }
    }

    Component {
        id: hueSaturationComponent

        HueSaturation {
            property string name
            property var properties: (["hue", "saturation", "lightness"])

            anchors.fill: image
            source: image
            hue: -0.3
            saturation: 0.5
            lightness: -0.1
        }
    }

    Component {
        id: levelAdjustComponent

        LevelAdjust {
            property string name

            anchors.fill: image
            source: image
            minimumOutput: "#00ffffff"
            maximumOutput: "#ff000000"
        }
    }
}
