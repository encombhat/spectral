import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2

import Spectral.Setting 0.1

Label {
    property bool coloredBackground

    color: coloredBackground ? "white": Material.foreground

    wrapMode: Label.Wrap
    linkColor: coloredBackground ? "white" : Material.accent
    textFormat: Text.RichText

    onLinkActivated: Qt.openUrlExternally(link)
}