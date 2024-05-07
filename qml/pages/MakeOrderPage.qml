import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.LocalStorage 2.0
import QtGraphicalEffects 1



Page {
    objectName: "makeOrderPage"
    allowedOrientations: Orientation.All
    backgroundColor: "white"

    QtObject {
        id: qtObj
        property var db;

        function deleteAll(){
            db.transaction(function (tx) {
                tx.executeSql("DELETE FROM Orders;");
            });
        }

        Component.onCompleted: {
            db = LocalStorage.openDatabaseSync("orders", "1.0");
        }
    }

    Text {
        id: pageLableId
        text: "Оформление"
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right

        anchors.topMargin: 16

        horizontalAlignment: Text.AlignHCenter
        font.pointSize: 48
        font.weight: Font.DemiBold
    }
    Text {
        id: errorTextId
        anchors.top: pageLableId.bottom
        anchors.left: parent.left
        anchors.right: parent.right

        anchors.topMargin: 16
        horizontalAlignment: Text.AlignHCenter
        font.weight: Font.DemiBold
        font.pointSize: 32
        color: "red"

        visible: false

        anchors.leftMargin: 48
        anchors.rightMargin: 48

        wrapMode: Text.WordWrap

        text: "Пожалуйста, введите все данные"
    }

    Text {
        id: editNameTextId
        text: "Имя:"

        anchors.top: errorTextId.visible ? errorTextId.bottom : pageLableId.bottom
        anchors.left: parent.left
        anchors.right: parent.right

        anchors.topMargin: 32
        anchors.leftMargin: 16

//        font.weight: Font.DemiBold
    }


    Rectangle {
            id: editNameContainer

            TextEdit {
                width: parent.width

                verticalAlignment: Image.AlignVCenter

                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.right: parent.right

                anchors.leftMargin: 16
                anchors.rightMargin: 16


                wrapMode: TextEdit.Wrap

                id: editNameId

                property string placeholderText: "Введите ваше имя"

                Text {

                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.left: parent.left
                    anchors.right: parent.right

                    verticalAlignment: Image.AlignVCenter

                    text: editNameId.placeholderText
                    color: "#aaa"
                    visible: !editNameId.text
                }
                onFocusChanged: {
                    if (focus)
                        editNameShadowId.visible = true
                    else
                        editNameShadowId.visible = false
                }

            }

            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top:  editNameTextId.bottom

            anchors.topMargin: 16
            anchors.leftMargin: 24
            anchors.rightMargin: 24

            height: editNameId.contentHeight  + 20
            border.width: 2
            border.color: "#d86814"
            radius: 4
        }
    DropShadow {
            id: editNameShadowId
            visible: false

            anchors.fill: editNameContainer
            horizontalOffset: 3
            verticalOffset: 3
            radius: 16.0
            samples: 17
            color: "#d86814"
            source: editNameContainer
   }
    Text {
        id: editLastNameTextId
        text: "Фамилия:"

        anchors.top: editNameContainer.bottom
        anchors.left: parent.left
        anchors.right: parent.right

        anchors.topMargin: 32
        anchors.leftMargin: 16

//        font.weight: Font.DemiBold
    }
    Rectangle {
            id: editLastNameContainer

            TextEdit {
                width: parent.width

                verticalAlignment: Image.AlignVCenter

                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.right: parent.right

                anchors.leftMargin: 16
                anchors.rightMargin: 16

                wrapMode: TextEdit.Wrap

                id: editLastNameId

                property string placeholderText: "Введите вашу фамилию"

                Text {

                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.left: parent.left
                    anchors.right: parent.right

                    verticalAlignment: Image.AlignVCenter

                    text: editLastNameId.placeholderText
                    color: "#aaa"
                    visible: !editLastNameId.text
                }
                onFocusChanged: {
                    if (focus)
                        editLastNameShadowId.visible = true
                    else
                        editLastNameShadowId.visible = false
                }
            }

            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top:  editLastNameTextId.bottom

            anchors.topMargin: 16
            anchors.leftMargin: 24
            anchors.rightMargin: 24

            height: editLastNameId.contentHeight  + 20
            border.width: 2
            border.color: "#d86814"
            radius: 4
        }
    DropShadow {
            id: editLastNameShadowId
            visible: false

            anchors.fill: editLastNameContainer
            horizontalOffset: 3
            verticalOffset: 3
            radius: 16.0
            samples: 17
            color: "#d86814"
            source: editLastNameContainer
   }
    Text {
        id: editAdressTextId
        text: "Куда доставить:"

        anchors.top: editLastNameContainer.bottom
        anchors.left: parent.left
        anchors.right: parent.right

        anchors.topMargin: 32
        anchors.leftMargin: 16

//        font.weight: Font.DemiBold
    }
    Rectangle {
            id: editAdressContainer

            TextEdit {
                width: parent.width

                verticalAlignment: Image.AlignVCenter

                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.right: parent.right

                anchors.leftMargin: 16
                anchors.rightMargin: 16

                wrapMode: TextEdit.Wrap

                id: editAdressId

                property string placeholderText: "Введите ваш адрес"

                Text {

                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.left: parent.left
                    anchors.right: parent.right

                    verticalAlignment: Image.AlignVCenter

                    text: editAdressId.placeholderText
                    color: "#aaa"
                    visible: !editAdressId.text
                }
                onFocusChanged: {
                    if (focus)
                        editAdressShadowId.visible = true
                    else
                        editAdressShadowId.visible = false
                }
            }

            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top:  editAdressTextId.bottom

            anchors.topMargin: 16
            anchors.leftMargin: 24
            anchors.rightMargin: 24

            height: editAdressId.contentHeight  + 20
            border.width: 2
            border.color: "#d86814"
            radius: 4
        }
    DropShadow {
            id: editAdressShadowId
            visible: false

            anchors.fill: editAdressContainer
            horizontalOffset: 3
            verticalOffset: 3
            radius: 16.0
            samples: 17
            color: "#d86814"
            source: editAdressContainer
   }
    Text {
        id: editCardNumbTextId
        text: "Номер карты:"

        anchors.top: editAdressContainer.bottom
        anchors.left: parent.left
        anchors.right: parent.right

        anchors.topMargin: 32
        anchors.leftMargin: 16

//        font.weight: Font.DemiBold
    }

    Rectangle {
            id: editCardNumbContainer

            TextEdit {
                width: parent.width

                verticalAlignment: Image.AlignVCenter

                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.right: parent.right

                anchors.leftMargin: 16
                anchors.rightMargin: 16

                wrapMode: TextEdit.Wrap

                id: editCardNumbId

                property string placeholderText: "Введите номер вашей карты"

                Text {

                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.left: parent.left
                    anchors.right: parent.right

                    verticalAlignment: Image.AlignVCenter

                    text: editCardNumbId.placeholderText
                    color: "#aaa"
                    visible: !editCardNumbId.text
                }
                onFocusChanged: {
                    if (focus)
                        editCardNumbShadowId.visible = true
                    else
                        editCardNumbShadowId.visible = false
                }
            }

            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top:  editCardNumbTextId.bottom

            anchors.topMargin: 16
            anchors.leftMargin: 24
            anchors.rightMargin: 24

            height: editCardNumbId.contentHeight  + 20
            border.width: 2
            border.color: "#d86814"
            radius: 4
        }
    DropShadow {
            id: editCardNumbShadowId
            visible: false

            anchors.fill: editCardNumbContainer
            horizontalOffset: 3
            verticalOffset: 3
            radius: 16.0
            samples: 17
            color: "#d86814"
            source: editCardNumbContainer
   }
    Text {
        id: editTermTextId
        text: "Срок действия и CVV:"

        anchors.top: editCardNumbContainer.bottom
        anchors.left: parent.left
        anchors.right: parent.right

        anchors.topMargin: 32
        anchors.leftMargin: 16

//        font.weight: Font.DemiBold
    }

    Rectangle {
            id: editTermContainer

            TextInput {
                width: parent.width

                verticalAlignment: Image.AlignVCenter

                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.right: parent.right

                anchors.leftMargin: 16
                anchors.rightMargin: 16

                wrapMode: TextEdit.Wrap

                id: editTermId

                property string placeholderText: "Введите Срок"

                Text {

                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.left: parent.left
                    anchors.right: parent.right

                    verticalAlignment: Image.AlignVCenter

                    text: editTermId.placeholderText
                    color: "#aaa"
                    visible: !editTermId.text
                }
                onFocusChanged: {
                    if (focus)
                        editTermShadowId.visible = true
                    else
                        editTermShadowId.visible = false
                }
                property bool deliting: false
//                onTextChanged: {
//                    print(acceptableInput)
////                    editTermId.text = editTermId.text.replace("\n", '')
////                    if(editTermId.length > 4)
////                        editTermId.remove(4, editTermId.length);
//                }
                inputMethodHints: Qt.ImhDigitsOnly
                inputMask: "00:00;_"
//                validator: RegExpValidator { regExp: /^(0?[0-9\s]|[1][0-2\s]):([2][4-9\s]|[3-9\s][0-9\s])$ / }
            }

            anchors.left: parent.left
            anchors.top:  editTermTextId.bottom

            anchors.topMargin: 16
            anchors.leftMargin: 24

            width: (parent.width - 128) / 2

            height: editTermId.contentHeight  + 20
            border.width: 2
            border.color: "#d86814"
            radius: 4
        }
    DropShadow {
            id: editTermShadowId
            visible: false

            anchors.fill: editTermContainer
            horizontalOffset: 3
            verticalOffset: 3
            radius: 16.0
            samples: 17
            color: "#d86814"
            source: editTermContainer
   }


    Rectangle {
            id: editCVVContainer

            TextEdit {
                width: parent.width

                verticalAlignment: Image.AlignVCenter

                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.right: parent.right

                anchors.leftMargin: 16
                anchors.rightMargin: 16

                wrapMode: TextEdit.Wrap

                id: editCVVId

                property string placeholderText: "Введите CVV"

                Text {

                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.left: parent.left
                    anchors.right: parent.right

                    verticalAlignment: Image.AlignVCenter

                    text: editCVVId.placeholderText
                    color: "#aaa"
                    visible: !editCVVId.text
                }
                onFocusChanged: {
                    if (focus)
                        editCVVShadowId.visible = true
                    else
                        editCVVShadowId.visible = false
                }
                onTextChanged: {
                    editCVVId.text = editCVVId.text.replace("\n", '')
                    if(editCVVId.length > 3)
                        editCVVId.remove(3, editCVVId.length);
                }
                inputMethodHints: Qt.ImhDigitsOnly

            }

            anchors.right: parent.right
            anchors.top:  editTermTextId.bottom

            anchors.topMargin: 16
            anchors.rightMargin: 24

            width: (parent.width - 128) / 2

            height: editCVVId.contentHeight  + 20
            border.width: 2
            border.color: "#d86814"
            radius: 4
        }
    DropShadow {
            id: editCVVShadowId
            visible: false

            anchors.fill: editCVVContainer
            horizontalOffset: 3
            verticalOffset: 3
            radius: 16.0
            samples: 17
            color: "#d86814"
            source: editCVVContainer
   }

    Button {
        id: btn

        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right

        anchors.bottomMargin: 30
        anchors.leftMargin: 30
        anchors.rightMargin: 30

        height: 100

        text: "Оформить"
        color: "white"
        backgroundColor: "#d86814"

        onClicked: {
            if (editNameId.text.length > 0 && editLastNameId.text.length > 0 && editAdressId.text.length > 0 && editCardNumbId.text.length > 0 && editTermId.text.length > 0 && editCVVId.text.length > 0){
                qtObj.deleteAll()
                errorTextId.visible = false
                pageStack.push(Qt.resolvedUrl("ProductsListPage.qml"))
            } else
                errorTextId.visible = true
        }
    }

}
