import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:library/Controler/FavoriteListController/FavController.dart';
import 'package:library/Controler/dashboard/dashboard_controller.dart';
import 'package:library/Controler/home/BookController.dart';
import 'package:library/Controler/home/homecontroller.dart';
import 'package:library/Model/BookModle/BookModle.dart';
import 'package:library/View/Notfication/Notfication.dart';
import 'package:library/View/dashboard/dashboard_page.dart';
import 'package:library/View/widgets/Appbar/view_drawer/drawer_common.dart';
import 'package:get/get.dart';
import 'Serch.dart';
import 'readBook.dart';

// ignore: must_be_immutable
class Bookbage extends GetView<HomeController> {
  final id;
  Bookbage(this.id);
  //const DetilsCatogery({Key? key}) : super(key: key);

//   @override
//   _DetilsCatogeryState createState() => _DetilsCatogeryState();
// }
  DashboardController dashboard = Get.put(DashboardController());
  BookController bookController = Get.put(BookController());
// class _DetilsCatogeryState extends State<DetilsCatogery> {
  DashboardPage dashboardPage = Get.put(DashboardPage());
  int _selected = 0;
  @override
  Widget build(BuildContext context) {
    final listt = bookController.book;
    return Scaffold(
        drawer: DrawerHome(),
        appBar: AppBar(
            backgroundColor: Color(0xFF5A8DEE),
            title: Center(child: Text('30'.tr)),
            actions: [
              IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    showSearch(
                        context: context,
                        delegate: DataSearch(list: bookController.book));
                  }),
              // IconButton(onPressed: () {}, icon: Icon(Icons.shopping_cart_outlined)),

              // new Stack(
              //   children: <Widget>[
              //     new IconButton(
              //         icon: Icon(Icons.notifications),
              //         onPressed: () {
              //           Get.to(() => UserNotification(
              //                 notifications: controller.notifications,
              //               ));
              //           //   setState(() {
              //           controller.makeAsRead();
              //           // });
              //         }),
              //     controller.notifications.length != 0
              //         ? new Positioned(
              //             right: 11,
              //             top: 11,
              //             child: new Container(
              //               padding: EdgeInsets.all(2),
              //               decoration: new BoxDecoration(
              //                 color: Colors.red,
              //                 borderRadius: BorderRadius.circular(6),
              //               ),
              //               constraints: BoxConstraints(
              //                 minWidth: 14,
              //                 minHeight: 14,
              //               ),
              //               child: Text(
              //                 '${controller.notifications.length}',
              //                 style: TextStyle(
              //                   color: Colors.white,
              //                   fontSize: 8,
              //                 ),
              //                 textAlign: TextAlign.center,
              //               ),
              //             ),
              //           )
              //         : new Container()
              //   ],
              // )
      
            ] // shape: RoundedRectangleBorder(
            //   borderRadius: BorderRadius.vertical(
            //     bottom: Radius.circular(10.0),
            //   ),
            // ),
//      actions: [Icon(Icons.dehaze)],
            ),
        //  AppBar(
        //   title: Text('30'.tr),
        // ),
        body: GetBuilder<BookController>(builder: (controller) //=>
            {
          BookCategory bookcategory =
              controller.bookList[controller.indexCateg];
          // Book post=
          return
              //  color: Colors.blue[100],
              ListView(
            children: [
              Container(
                height: 50.0,
                margin: const EdgeInsets.only(top: 10, bottom: 6),
                child: ListView.builder(
                    shrinkWrap: false,
                    dragStartBehavior: DragStartBehavior.down,
                    reverse: true,
                    physics: const ScrollPhysics(),
                    itemCount: 10, //controller.bookList
                    //.length, //categoriescontroller.categories_all.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      //             BookCategory post = controller.bookList[index];
                      BookCategory bookcategory = controller.bookList[index];
                      return InkWell(
                        onTap: () {
                          controller.loadBook(index);
                          //Get.to(Bookbage(index));
                          //    dashboard.changeTabIndex(1);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                spreadRadius: 4,
                                blurRadius: 1,
                                //       offset: const Offset(0, 5), // changes position of shadow
                              ),
                            ],
                          ),

                          margin: EdgeInsets.only(top: 8, right: 20, bottom: 8),
                          // decoration: BoxDecoration(
                          //     borderRadius: BorderRadius.circular(1),
                          //     color: Colors.blue[100]),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 1.0,
                            vertical: 1.0,
                          ),
                          child: ChoiceChip(
                            backgroundColor: Colors.white,
                            label: Text(
                              '${bookcategory.name}',
                              style: TextStyle(
                                color: Theme.of(context).accentColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ), //'${post.name}'),
                            selected: controller.indexCateg == index,
                          ),
                        ),
                      );
                    }),
              ),
              Divider(
                color: Colors.black38,
                height: 1,
              ),
              Container(
                // color: Colors.blue[100],
                margin: const EdgeInsets.only(top: 3, bottom: 3),
                height: 750,
                child: ListView.builder(
                    shrinkWrap: false,
                    dragStartBehavior: DragStartBehavior.down,
                    //     reverse: true,
                    physics: const ScrollPhysics(),
                    itemCount: bookcategory.book!.length,
                    //.length, //categoriescontroller.categories_all.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      Book book = bookcategory.book![index];
                      if (bookcategory.book!.length == 0) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return InkWell(
                          child: Container(
                            margin: EdgeInsets.all(3),
                            height: 155,
                            width: 400,
                            decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                  // color: Colors.blue[300],
                                  //color: Color(0xFFBBDEFB),
                                  color: Colors.black12,
                                  spreadRadius: 1,
                                  blurRadius: 1,
                                  // offset: Offset(8,
                                  //     5), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Card(
                              // color: Colors.blue[100],
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 2,
                                    child: // book.image != null
                                        //? Image.network(
                                        //  'http://192.168.0.191:8000/storage/ebook/' +
                                        //    book.image!)
                                        //:
                                        Image.asset("images/books_pile.PNG"),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Container(
                                        alignment: Alignment.topRight,
                                        //              height: 220,
                                        margin: EdgeInsets.only(right: 5),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Expanded(
                                              child: Row(
                                                children: <Widget>[
                                                  Text(
                                                    '${book.name}', //+ book!.name!
                                                    style: TextStyle(
                                                        color: Theme.of(context)
                                                            .accentColor),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Row(
                                                children: <Widget>[
                                                  Text(
                                                    "${book.publisher}", //+ book!.name!
                                                    style: TextStyle(
                                                        color: Theme.of(context)
                                                            .accentColor),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Row(
                                                children: <Widget>[
                                                  Text(
                                                    '${book.author}', //+ book!.name!
                                                    style: TextStyle(
                                                        color: Theme.of(context)
                                                            .accentColor),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            GetBuilder<FavController>(
                                                builder: (controller) {
                                              return Expanded(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: <Widget>[
                                                    InkWell(
                                                      child: Icon(
                                                        Icons.favorite_border,
                                                      ),
                                                      onTap: () {
                                                        bookController
                                                            .readBook(index);
                                                        controller.checkBook(
                                                            book.id!, book);
                                                        if (controller
                                                                .selected ==
                                                            true) {
                                                          print("Exist");
                                                          // controller.deletebook(
                                                          //     widget.infobook.id!);
                                                        } else {
                                                          print("Notfound");
                                                          // controller
                                                          //     .insertBook(widget.infobook);

                                                        }
                                                      },
                                                    ),
                                                    IconButton(
                                                        onPressed: () {},
                                                        icon: Icon(Icons
                                                            .local_library_rounded)),
                                                  ],
                                                ),
                                              );
                                            })
                                          ],
                                        )),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          onTap: () {
                            Get.to(ReadBook(book, bookcategory.name!));
                            controller.readBook(index);
                          },
                        );
                      }
                    }),
              ),
            ],
          );
        }));
  }
}
