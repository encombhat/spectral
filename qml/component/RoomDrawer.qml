import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtQuick.Layouts 1.3
import Matrique 0.1

Drawer {
    property var room

    id: roomDrawer

    edge: Qt.RightEdge
    interactive: false

    ToolButton {
        contentItem: MaterialIcon { icon: "\ue5c4" }

        onClicked: roomDrawer.close()
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 32

        ImageStatus {
            Layout.preferredWidth: 64
            Layout.preferredHeight: 64
            Layout.alignment: Qt.AlignHCenter

            source: room && room.avatarUrl != "" ? "image://mxc/" + room.avatarUrl : null
            displayText: room ? room.displayName : ""
        }

        Label {
            Layout.fillWidth: true

            horizontalAlignment: Text.AlignHCenter
            text: room && room.id ? room.id : ""
        }

        Label {
            Layout.fillWidth: true

            horizontalAlignment: Text.AlignHCenter
            text: room && room.canonicalAlias ? room.canonicalAlias : "No Canonical Alias"
        }

        RowLayout {
            Layout.fillWidth: true

            TextField {
                Layout.fillWidth: true

                id: roomNameField
                text: room && room.name ? room.name : ""
            }

            ItemDelegate {
                Layout.preferredWidth: height
                Layout.preferredHeight: parent.height

                contentItem: MaterialIcon { icon: "\ue5ca" }

                onClicked: room.setName(roomNameField.text)
            }
        }

        RowLayout {
            Layout.fillWidth: true

            TextField {
                Layout.fillWidth: true

                id: roomTopicField

                text: room && room.topic ? room.topic : ""
            }

            ItemDelegate {
                Layout.preferredWidth: height
                Layout.preferredHeight: parent.height

                contentItem: MaterialIcon { icon: "\ue5ca" }

                onClicked: room.setTopic(roomTopicField.text)
            }
        }

        ListView {
            Layout.fillWidth: true
            Layout.fillHeight: true

            clip: true

            boundsBehavior: Flickable.DragOverBounds

            delegate: ItemDelegate {
                width: parent.width
                height: 48

                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 8
                    spacing: 12

                    ImageStatus {
                        Layout.preferredWidth: height
                        Layout.fillHeight: true

                        source: avatar != "" ? "image://mxc/" + avatar : ""
                        displayText: name
                    }

                    Label {
                        Layout.fillWidth: true

                        text: name
                    }
                }
            }

            model: UserListModel {
                id: userListModel

                room: roomDrawer.room
            }

            ScrollBar.vertical: ScrollBar {}
        }

        Button {
            Layout.fillWidth: true

            text: "Invite User"
            flat: true
            highlighted: true

            onClicked: inviteUserDialog.open()

            Dialog {
                x: (window.width - width) / 2
                y: (window.height - height) / 2
                width: 360

                id: inviteUserDialog

                parent: ApplicationWindow.overlay

                title: "Input User ID"
                modal: true
                standardButtons: Dialog.Ok | Dialog.Cancel

                contentItem: TextField {
                    id: inviteUserDialogTextField
                    placeholderText: "@bot:matrix.org"
                }

                onAccepted: room.inviteToRoom(inviteUserDialogTextField.text)
            }
        }
    }
}

