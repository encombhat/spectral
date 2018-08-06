import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtQuick.Layouts 1.3

Rectangle {
    property bool flat: false
    property bool highlighted: false
    property string displayText
    property alias timeLabelVisible: timeText.visible

    property int maximumWidth

    readonly property bool darkBackground: highlighted && !flat

    id: messageRect

    width: Math.min(Math.max(messageText.implicitWidth, (timeText.visible ? timeText.implicitWidth : 0)) + 24, maximumWidth)
    height: messageText.implicitHeight + (timeText.visible ? timeText.implicitHeight : 0) + 24

    color: flat ? "transparent" : highlighted ? Material.accent : background
    border.color: Material.accent
    border.width: flat ? 2 : 0

    ColumnLayout {
        id: messageColumn

        anchors.fill: parent
        anchors.margins: 12
        spacing: 0

        Label {
            id: messageText
            Layout.maximumWidth: parent.width
            text: displayText
            color: darkBackground ? "white": Material.foreground

            wrapMode: Label.Wrap
            linkColor: darkBackground ? "white" : Material.accent
            textFormat: Text.StyledText
            onLinkActivated: Qt.openUrlExternally(link)
        }

        Label {
            id: timeText
            Layout.alignment: Qt.AlignRight
            text: Qt.formatTime(time, "hh:mm")
            color: darkBackground ? "white" : "grey"
            font.pointSize: 8
        }
    }
}