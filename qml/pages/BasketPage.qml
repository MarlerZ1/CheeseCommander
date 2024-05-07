import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.LocalStorage 2.0
import QtGraphicalEffects 1


Page {
    objectName: "productsListPage"
    allowedOrientations: Orientation.All
    backgroundColor: "white"

    QtObject {
        id: qtObj
        property var db;

        function initialisation(){
            db.transaction(function (tx) {
                tx.executeSql("INSERT INTO Orders (products_id, count) VALUES (1, 4);");
                tx.executeSql("INSERT INTO Orders (products_id, count) VALUES (2, 4);");
            });
        }

        function deleteAll(){
            db.transaction(function (tx) {
                tx.executeSql("DELETE FROM Orders;");
            });
        }

        function deleteById(id){
            db.transaction(function (tx) {
                tx.executeSql("DELETE FROM Orders WHERE orders_id=?;",[id]);
            });
        }

        function selectProductsBasket(orders,callback) {
            db.readTransaction(function (tx) {
//                tx.executeSql("INSERT INTO notes (note) VALUES (?);", [noteText]);
                var products = []
//                result += tx.executeSql("SELECT * FROM Products;").rows
                for (var i = 0; i < orders.length; i++){
                    var result = tx.executeSql("SELECT * FROM Products WHERE products_id=?;",[orders.item(i).products_id]).rows
                    //print("res len: ", result.length)
                    //for (var j = 0; j < result.length; j++) {
                        products.push(result.item(0))
                    //}

                    //print(products[i].products_id, orders.item(i).products_id)
                }

                //print(tx.executeSql("SELECT * FROM Products WHERE products_id=?;",[orders.item(0).products_id]).rows.item(0).products_id)
                callback(products);
            });
        }


        function selectOrder(products_id, callback){
            db.readTransaction(function (tx){
                var result = tx.executeSql("SELECT * FROM Orders WHERE products_id=?;",[products_id]);
                callback(result.rows.item(0))
            })
        }

        function selectOrders(callback) {
            db.readTransaction(function (tx) {
                var result = tx.executeSql("SELECT * FROM Orders;");
                callback(result.rows)
            });
        }

        function changeCount(dbId, count){
            db.transaction(function (tx) {
                tx.executeSql("UPDATE Orders SET count=? WHERE orders_id=?;",[count, dbId]);
            })
        }

        Component.onCompleted: {
            db = LocalStorage.openDatabaseSync("orders", "1.0");
//            deleteAll()
//            initialisation()
            printBasket()
//            selectOrders(function(orders) {
////                for (var j = 0; j < orders.length; j++){
////                    print(orders.item(j).orders_id,orders.item(j).products_id)
////                }

////                print(orders)


////                productsListModel.append({name: products.item(i).name, img_path: products.item(i).img_path, decription: products.item(i).description, price: products.item(i).price, count: });
//                selectProductsBasket(orders, function(products){

////                    print (products.length)
//                   for (var i = 0; i < products.length; i++){
//                       selectOrder(products[i].products_id, function(order){
//                           productsListModel.append({name: products[i].name, img_path: products[i].img_path, decription: products[i].description, price: products[i].price, count: order.count});
//                           print("products_id: ", products[i].products_id)
//                       })
//                    }

//                })


//            })

//            selectProductsBasket(orders)

        }
    }

    Text {
        id: pageLableId
        text: "Корзина"
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right

        anchors.topMargin: 16

        horizontalAlignment: Text.AlignHCenter
        font.pointSize: 48
        font.weight: Font.DemiBold
    }


    Image {
        id: catImgId

        visible: false

        anchors.bottom: emptyLableTextId.top
        anchors.left: parent.left
        anchors.right: parent.right

        anchors.bottomMargin: 16

        fillMode: Image.Pad

//        width: 256
//        height: 256

//        verticalAlignment: Image.AlignVCenter
        horizontalAlignment: Image.AlignHCenter

        source: "images/cat.png"
    }

    Text {
        id: emptyLableTextId

        visible: false

        font.pointSize: 32

        text: "Ой, тут пусто!"

        anchors.bottom: emptyTextId.top

        anchors.left: parent.left
        anchors.right: parent.right

        horizontalAlignment: Text.AlignHCenter
    }

    Text {
        id: emptyTextId

        visible: false

        text: 'Ваша корзина пуста, добавьте понравившийся товар из "Меню"'

        anchors.bottom: goBackBtnId.top

        anchors.left: parent.left
        anchors.right: parent.right

        anchors.leftMargin: 30
        anchors.rightMargin: 30
        anchors.bottomMargin: 320

        horizontalAlignment: Text.AlignHCenter

        wrapMode: Text.WordWrap
    }


    Button {
        id: goBackBtnId

        visible: false

        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right

        anchors.bottomMargin: 30
        anchors.leftMargin: 30
        anchors.rightMargin: 30

        height: 100

        text: "Вернуть к выбору"
        color: "white"
        backgroundColor: "#d86814"

        onClicked: {
            pageStack.navigateBack(PageStackAction.Animated)
            //pageStack.push(Qt.resolvedUrl("ProductsListPage.qml"))
        }
    }

    function changeVisualVariant() {
        if (silicaListViewId.count > 0){
            silicaListViewId.visible = true
            makeOrderBtnId.visible = true

            emptyLableTextId.visible = false
            emptyTextId.visible = false
            goBackBtnId.visible = false
            catImgId.visible = false
        } else {
            silicaListViewId.visible = false
            makeOrderBtnId.visible = false

            emptyLableTextId.visible = true
            emptyTextId.visible = true
            goBackBtnId.visible = true
            catImgId.visible = true
        }
    }

    SilicaListView {
        id: silicaListViewId
        anchors.top: pageLableId.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right

        anchors.topMargin: 32
        anchors.leftMargin: 72
        anchors.rightMargin: 72

        spacing: 16

        model: ListModel{
            id: productsListModel
        }

        delegate: ListItem {
            height: labelId.height + imageId.height + countControlBlockId.height + priceTextId.height + 96
            Rectangle {
                id: itemRectangleId

                border.color: "black"
                border.width: 1
                radius: 16
                height: labelId.height + imageId.height + countControlBlockId.height + priceTextId.height + 96

                anchors.left: parent.left
                anchors.right: parent.right



                Label {
                    id: labelId
                    x: Theme.horizontalPageMargin
                    text: name

                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.right: parent.right

                    anchors.topMargin: 16
                    anchors.leftMargin: 64
                    anchors.rightMargin: 64

                    font.weight: Font.DemiBold

                    wrapMode: Text.WordWrap
                    horizontalAlignment: Text.AlignHCenter
                }

                Rectangle {
                    id: deleteBtn

                    anchors.top: parent.top
                    anchors.right: parent.right

                    anchors.topMargin: 16
                    anchors.rightMargin: 16

                    width: 40
                    height: 40
                    radius: 20

                    color: "#d86814"

                    Text {
                        text: "x"
                        color: "white"

//                        font.weight: Font.DemiBold
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter

                        anchors.top: parent.top
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 8
                    }

                    MouseArea {
                        width: parent.width
                        height: parent.height

                        onClicked: {
                            productsListModel.remove(index)
                            qtObj.deleteById(dbId.text)
                            changeVisualVariant()
                        }
                    }
                }

                DropShadow {
                       anchors.fill: deleteBtn
                       horizontalOffset: 3
                       verticalOffset: 3
                       radius: 16.0
                       samples: 17
                       color: "#d86814"
                       source: deleteBtn
               }



                Image {
                    id: imageId
                    source: img_path
                    height: 300
                    anchors.top: labelId.bottom
                    anchors.left: parent.left
                    anchors.right: parent.right

                    anchors.topMargin: 16
                    anchors.leftMargin: 24
                    anchors.rightMargin: 24
                }
                Rectangle {
                    height: 80

                    id: countControlBlockId

                    anchors.top: imageId.bottom
                    anchors.left: parent.left
                    anchors.right: parent.right

                    anchors.topMargin: 24
                    anchors.leftMargin: 64
                    anchors.rightMargin: 64

//                    border.color: "black"
//                    border.width: 1
//                    radius: 1

                   Button {
                    id: btnMinusId
                    text: "-"

                    color: "white"
                    backgroundColor: "#d86814"

                    anchors.top: countControlBlockId.top
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    width: 80
                    onClicked: {
                        if (countTextId.text > 1){
                            countTextId.text -= 1
                            priceTextId.text = "Стоимость: " + price * countTextId.text + " руб."
                            qtObj.changeCount(dbId.text, countTextId.text)
                        }
                    }

                   }
                   DropShadow {
                          anchors.fill: btnMinusId
                          horizontalOffset: 3
                          verticalOffset: 3
                          radius: 16.0
                          samples: 17
                          color: "#d86814"
                          source: btnMinusId
                  }
                    Rectangle {

                        id: countBlockId
                        anchors.top: countControlBlockId.top
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.bottom: parent.bottom

                        anchors.leftMargin: 180
                        anchors.rightMargin: 180

                        border.color: "#d86814"
                        border.width: 4
                        radius: 16

                        Text {
                            id: countTextId
                            text: count//COUNT

                            anchors.top: parent.top
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.bottom: parent.bottom


                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter

                        }


                    }
                    DropShadow {
                           anchors.fill: countBlockId
                           horizontalOffset: 3
                           verticalOffset: 3
                           radius: 16.0
                           samples: 17
                           color: "#d86814"
                           source: countBlockId
                   }

                    Button {
                        id: btnPlusId
                        text: "+"

                        color: "white"
                        backgroundColor: "#d86814"

                        anchors.top: countControlBlockId.top
                        anchors.right: parent.right
                        anchors.bottom: parent.bottom
                        width: 80

                        onClicked: {
                            if (countTextId.text < 99){
                                countTextId.text = parseInt(countTextId.text) + 1
                                priceTextId.text = "Стоимость: " + price * countTextId.text + " руб."
                                qtObj.changeCount(dbId.text, countTextId.text)
                            }
                        }
                    }

                    DropShadow {
                           anchors.fill: btnPlusId
                           horizontalOffset: 3
                           verticalOffset: 3
                           radius: 16.0
                           samples: 17
                           color: "#d86814"
                           source: btnPlusId
                   }
                }

                Rectangle {
                    id: rectanglePriceId

                    anchors.top: countControlBlockId.bottom
                    anchors.left: parent.left
                    anchors.right: parent.right

                    anchors.topMargin: 24
                    anchors.leftMargin: 24
                    anchors.rightMargin: 24

//                    color: "#d86814"
//                    border.color: "#d86814"
//                    border.width: 2
                    radius: 4
                    height: 48

                    Text {
                        id: priceTextId

//                        color: "white"
                        text: "Стоимость: " + price * count + " руб."

                        anchors.top: parent.top
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.bottom: parent.bottom

                        anchors.leftMargin: 40
                        anchors.rightMargin: 40

                        horizontalAlignment: Text.AlignHCenter
                    }
                }
                Text {
                    visible: false
                    id: dbId
                    text: db_id
                }

            }
            DropShadow {
                   anchors.fill: itemRectangleId
                   horizontalOffset: 3
                   verticalOffset: 3
                   radius: 16.0
                   samples: 17
                   color: "#d86814"
                   source: itemRectangleId
           }
        }
    }

    Button {
        id: makeOrderBtnId

        visible: true

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
            pageStack.push(Qt.resolvedUrl("MakeOrderPage.qml"))
        }
    }

//    function textCrop(text){
//        const MAX_TEXT_LENGTH = 32

//        if (text.length > MAX_TEXT_LENGTH)
//            text = text.substring(0, MAX_TEXT_LENGTH) + '...'

//        return text
//    }

    function printBasket(){
        qtObj.selectOrders(function(orders) {
            qtObj.selectProductsBasket(orders, function(products){
               for (var i = 0; i < products.length; i++){
                   qtObj.selectOrder(products[i].products_id, function(order){
                       productsListModel.append({name: products[i].name, img_path: products[i].img_path, decription: products[i].description, price: products[i].price, count: order.count, db_id: order.orders_id});
                   })
                }
            })
        })
        changeVisualVariant()
    }
}
