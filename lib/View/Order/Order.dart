import 'package:flutter/material.dart';
import 'package:library/Controler/home/NotificationsController.dart';
import 'package:library/Controler/home/OrderController.dart';
import 'package:library/Controler/home/homecontroller.dart';
import 'package:library/Model/Order.dart';
import 'package:library/View/Notfication/Notfication.dart';
import 'package:library/View/widgets/Appbar/view_drawer/drawer_common.dart';
import 'package:get/get.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  OrderController orderController = Get.put(OrderController());
    NotificationsController notificationsController = Get.put(NotificationsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerHome(),
      appBar: AppBar(
          backgroundColor: Color(0xFF5A8DEE),
          title: Center(child: Text('Orders ')),
          actions: [
            new Stack(
              children: <Widget>[
                new IconButton(
                    icon: Icon(Icons.notifications),
                    onPressed: () {
                      Get.to(() => UserNotification(
                            notifications: notificationsController.notifications,
                          ));
                      //   setState(() {
                      notificationsController.makeAsRead();
                      // });
                    }),
                notificationsController.notifications.length != 0
                    ? new Positioned(
                        right: 11,
                        top: 11,
                        child: new Container(
                          padding: EdgeInsets.all(2),
                          decoration: new BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          constraints: BoxConstraints(
                            minWidth: 14,
                            minHeight: 14,
                          ),
                          child: Text(
                            '${notificationsController.notifications.length}',
                            style: TextStyle(
                              //   color: Theme.of(context).accentColor,
                              fontSize: 8,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    : new Container()
              ],
            )
          ] // shape: RoundedRectangleBorder(
          //   borderRadius: BorderRadius.vertical(
          //     bottom: Radius.circular(10.0),
          //   ),
          // ),
//      actions: [Icon(Icons.dehaze)],
          ),
      body: ListView(
        children: [
          GetBuilder<OrderController>(
            //init: HomeController(),
            builder: (controller) {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.order.length,
                  scrollDirection: Axis.vertical,
                  physics: ScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    Order order = controller.order[index];
                    // print(post);
                    return Container(
                      height: 100,
                      //width: 100,
                      child: Card(
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 2,
                              child: Image.asset("images/books_pile.PNG"),
                            ),
                            Expanded(
                              flex: 3,
                              child: Container(
                                  //alignment: Alignment.topRight,
                                  height: 60,
                                  margin: EdgeInsets.only(right: 5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        width: 30,
                                        margin:
                                            EdgeInsets.only(top: 0, bottom: 0),
                                        child: Text(
                                          'Name : ${order.nameDocu!.capitalize}',
                                          style: TextStyle(
                                              color:
                                                  Theme.of(context).accentColor,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w800),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          children: <Widget>[
                                            order.typeOrder == 1
                                                ? Text(
                                                    "Type : Project",
                                                    style: TextStyle(
                                                      color: Theme.of(context)
                                                          .accentColor,
                                                    ),
                                                  )
                                                : Text("Type : Book",
                                                    style: TextStyle(
                                                      color: Theme.of(context)
                                                          .accentColor,
                                                    ))
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          children: <Widget>[
                                            SingleChildScrollView(
                                              scrollDirection: Axis.vertical,
                                              child: Text(
                                                "Category : ${order.catDocu}",
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .accentColor,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            },
          ),
        ],
      ),
    );
  }
}
