import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.LocalStorage 2.0
import QtGraphicalEffects 1


Page {
    id: pageId
    objectName: "productsListPage"
    allowedOrientations: Orientation.All
    backgroundColor: "white"

    QtObject {
        id: qtObj
        property var db;



        function createTable() {
            db.transaction(function (tx){
                //tx.executeSql("DROP TABLE IF EXISTS Orders;")
                tx.executeSql("CREATE TABLE IF NOT EXISTS Products (products_id INTEGER PRIMARY KEY AUTOINCREMENT,name VARCHAR(40) NOT NULL,description TEXT NOT NULL,img_path CHAR(150) NULL,price INTEGER NOT NULL);");
                tx.executeSql("CREATE TABLE IF NOT EXISTS Orders (orders_id INTEGER PRIMARY KEY AUTOINCREMENT, count INTEGER NOT NULL,products_id INTEGER NOT NULL, FOREIGN KEY (products_id) REFERENCES Products(products_id));");
//                tx.executeSql("ALTER TABLE Orders ADD FOREIGN KEY R_6 (products_id) REFERENCES Products(products_id);");
            });
        }

        function initialisation(){
            db.transaction(function (tx){
                tx.executeSql("INSERT INTO Products (name, description, img_path, price ) VALUES (?,?,?,?);", ["Пицца с грибами", "Описаниеe e e e e e e e e e e e ee e e  e eee e e e e e e e e e  eeeee e e e e eeee e e e e eeee ee e e eeeeee e eeererere ere rere rererer ere rere erer ererwrr wr werw erwerfw erwer wererwr wrew r 1", "images/pizza_1.png", 9999]);
                tx.executeSql("INSERT INTO Products (name, description, img_path, price) VALUES (?,?,?,?);", ["Пицца с пеперони", "Описание 2", "images/pizza_2.png", 11]);
                tx.executeSql("INSERT INTO Products (name, description, img_path, price ) VALUES (?,?,?,?);", ["Квадратная пицца, а зачем? Не понятно...", "Опис3333333333333333e e e e e e e ee e e  e eee e e e e e e e e e  eeeee e e e e eeee e e e e eeee ee e e eeeeee e eeererere ere rere rererer ere rere erer ererwrr wr werw erwerfw erwer wererwr wrew r 1", "images/pizza_3.png", 9999]);
                tx.executeSql("INSERT INTO Products (name, description, img_path, price) VALUES (?,?,?,?);", ["Пицца с каким-то странным зеленым соусом", "4Опис4ани4", "images/pizza_4.png", 55]);
                tx.executeSql("INSERT INTO Products (name, description, img_path, price) VALUES (?,?,?,?);", ["Пицца маленькая", "4Опис4ани4", "images/pizza_5.png", 999]);
                tx.executeSql("INSERT INTO Products (name, description, img_path, price) VALUES (?,?,?,?);", ["Пицца", "4Опис4ани4", "images/pizza_6.png", 799]);
                tx.executeSql("INSERT INTO Products (name, description, img_path, price) VALUES (?,?,?,?);", ["Пицца 4 в 1", "4Опис4ани4", "images/pizza_7.png", 11]);
            });
        }

//        function insertNote(noteText){
//            db.transaction(function (tx){
//                tx.executeSql("INSERT INTO notes (note) VALUES (?);", [noteText]);
//            });
//        }

//        function deleteBook(id){
//            db.transaction(function (tx) {
//                tx.executeSql("DELETE FROM notes WHERE id=?;", [id]);
//            });
//        }

        function deleteAll(id){
            db.transaction(function (tx) {
                tx.executeSql("DELETE FROM Products;");
            });
        }


        function selectProduct(callback) {
            db.readTransaction(function (tx) {
                var result = tx.executeSql("SELECT * FROM Products;");
                callback(result.rows);
            });
        }

        function addToBasket(id){
            db.transaction(function (tx) {
                tx.executeSql("INSERT INTO Orders (products_id, count) VALUES (?, 1);", [id]);
            });
        }
        function selectOrder(products_id, callback){
            db.readTransaction(function (tx){
                var result = tx.executeSql("SELECT * FROM Orders WHERE products_id=?;",[products_id]);
                callback(result.rows.item(0))
            })
        }

        function changeCount(dbId, count){
            db.transaction(function (tx) {
                tx.executeSql("UPDATE Orders SET count=? WHERE orders_id=?;",[count, dbId]);
            })
        }

//        function selectByText(noteText, callback) {
//            db.readTransaction(function (tx) {
//                var result = tx.executeSql("SELECT * FROM notes WHERE note=?;", [noteText]);
//                callback(result.rows);
//            });

//        }
        Component.onCompleted: {
            db = LocalStorage.openDatabaseSync("orders", "1.0");
            deleteAll();
            createTable();
            initialisation();
        }
    }
    Text {
        id: pageLableId
        text: "Меню"
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right

        anchors.topMargin: 16

        horizontalAlignment: Text.AlignHCenter
        font.pointSize: 48
        font.weight: Font.DemiBold
    }

    SilicaListView {
        anchors.top: pageLableId.bottom
        anchors.bottom: btn.top
        anchors.left: parent.left
        anchors.right: parent.right

        anchors.topMargin: 16
        anchors.leftMargin: 72
        anchors.rightMargin: 72

        spacing: 16

        model: ListModel{
            id: productsListModel
        }

        delegate: ListItem {
            height: labelId.height + imageId.height + textId.height + priceTextId.height + 72
            Rectangle {
                id: itemRectangleId

                border.color: "black"
                border.width: 1
                radius: 16
                height: labelId.height + imageId.height + textId.height + priceTextId.height + 72

                anchors.left: parent.left
                anchors.right: parent.right
                MouseArea {
                    width: parent.width
                    height: parent.height

                    onClicked:{
                        qtObj.selectOrder(dbId.text, function(order){
                            if  (order) {
                                qtObj.changeCount(order.orders_id, order.count + 1)
                            } else
                                qtObj.addToBasket(dbId.text)
                        })
                    }
                }


                Label {
                    id: labelId
                    x: Theme.horizontalPageMargin
                    text: name

                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.right: parent.right

                    anchors.topMargin: 16
                    anchors.leftMargin: 24
                    anchors.rightMargin: 24

                    font.weight: Font.DemiBold

                    wrapMode: Text.WordWrap
                    horizontalAlignment: Text.AlignHCenter
    //                MouseArea {
    //                    width: parent.width
    //                    height: parent.height

    //                    onClicked: {
    //                        console.log(productsListModel.get(index).note)

    //                        qtObj.selectByText(productsListModel.get(index).note, function (notes){
    //                            qtObj.deleteBook(notes.item(0).id);
    //                            printNotes();
    //                        });

    //                    }
    //                }
                }
                Image {
                    id: imageId
                    source: img_path

                    anchors.top: labelId.bottom
                    anchors.left: parent.left
                    anchors.right: parent.right

                    height: 300

                    anchors.topMargin: 16
                    anchors.leftMargin: 24
                    anchors.rightMargin: 24
                }
                Text {
                    id: textId
                    text: textCrop(decription)
//                    anchors.centerIn: parent
                    anchors.top: imageId.bottom
                    anchors.left: parent.left
                    anchors.right: parent.right

                    anchors.topMargin: 16
                    anchors.leftMargin: 24
                    anchors.rightMargin: 24

                    horizontalAlignment: Text.AlignJustify

                    wrapMode: Text.WordWrap
                }

                Rectangle {
                    id: rectanglePriceId

                    anchors.top: textId.bottom
                    anchors.left: parent.left
                    anchors.right: parent.right

                    anchors.topMargin: 8
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
                        text: "Цена: " + price + " руб."

                        anchors.top: parent.top
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.bottom: parent.bottom

                        anchors.leftMargin: 40
                        anchors.rightMargin: 40

                        horizontalAlignment: Text.AlignHCenter
                    }


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

            Text {
                visible: false
                id: dbId
                text: db_id
            }
        }
    }

    function textCrop(text){
        const MAX_TEXT_LENGTH = 32

        if (text.length > MAX_TEXT_LENGTH)
            text = text.substring(0, MAX_TEXT_LENGTH) + '...'

        return text
    }

    function printProducts(){
        productsListModel.clear()
        qtObj.selectProduct(function (products){
            for (var i = 0; i < products.length; i++){
                productsListModel.append({name: products.item(i).name, img_path: products.item(i).img_path, decription: products.item(i).description, price: products.item(i).price, db_id: products.item(i).products_id});
            }
        });
    }

    Component.onCompleted: {
        printProducts();
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

        text: "В Корзину"
        color: "white"
        backgroundColor: "#d86814"

        onClicked: {
            pageStack.push(Qt.resolvedUrl("BasketPage.qml"))
            //qtObj.insertNote(qsTr(textEditId.text));
//            printProducts();
        }
    }
}
