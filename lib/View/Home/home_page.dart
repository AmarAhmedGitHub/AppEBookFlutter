import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:library/Controler/dashboard/dashboard_controller.dart';
import 'package:library/Controler/home/BookController.dart';
import 'package:library/Controler/home/EbookController.dart';
import 'package:library/Controler/home/NotificationsController.dart';
import 'package:library/Controler/home/ProjectController.dart';
import 'package:library/Controler/home/homecontroller.dart';
import 'package:library/Model/BookModle/BookModle.dart';
import 'package:library/Model/EBookModel/EBookModel.dart';
import 'package:library/Model/ProjectModel/CategoryProject.dart';
import 'package:library/View/DetailsView/Bookpage/Bookbage.dart';
import 'package:library/View/DetailsView/Ebookpage/Ebookbage.dart';
import 'package:library/View/DetailsView/Projectpage/Projectbage.dart';
import 'package:library/View/Notfication/Notfication.dart';
import 'package:library/View/widgets/Appbar/view_drawer/drawer_common.dart';
import 'package:get/get.dart';

//class HomeView extends GetView<HomeViewModel> {
// ignore: must_be_immutable
class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);
//  NotificationsController notifications = Get.put(NotificationsController());
  DashboardController dashboard = Get.put(DashboardController());

  String _selectedLang = "en";
  @override
  Widget build(BuildContext context) {
    //bool loading = false;
    return Scaffold(
        drawer: DrawerHome(),
        appBar: AppBar(
            backgroundColor: Color(0xFF5A8DEE),
            title: Center(
                child: Text(
              'Home Library ',
              style: TextStyle(
                  //  fontSize: _drawerFontSize,
                  // color: Theme.of(context).accentColor
                  ),
            )),
            actions: [
              //IconButton(onPressed: () {}, icon: Icon(Icons.search)),
              //  IconButton(onPressed: () {}, icon: Icon(Icons.search)),
              // IconButton(onPressed: () {}, icon: Icon(Icons.shopping_cart_outlined)),

              new Stack(
                children: <Widget>[
                  GetBuilder<NotificationsController>(
                      init: NotificationsController(),
                      builder: (controller) {
                        return IconButton(
                            icon: Icon(
                              Icons
                                  .notifications, //  fontSize: _drawerFontSize,
                              //color: Theme.of(context).accentColor,
                            ),
                            onPressed: () {
                              Get.to(() => UserNotification(
                                    notifications: controller.notifications,
                                  ));
                              //   setState(() {
                              controller.makeAsRead();
                              // });
                            });
                      }),
                  GetBuilder<NotificationsController>(
                      init: NotificationsController(),
                      builder: (controller) {
                        if (controller.notifications.length != 0) {
                          return Positioned(
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
                                '${controller.notifications.length}',
                                style: TextStyle(
                                    //  fontSize: _drawerFontSize,
                                    //color: Theme.of(context).accentColor
                                    ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        } else {
                          return Container();
                        }
                      })
                ],
              )
            ] // shape: RoundedRectangleBorder(
            //   borderRadius: BorderRadius.vertical(
            //     bottom: Radius.circular(10.0),
            //   ),
            // ),
//      actions: [Icon(Icons.dehaze)],
            ),
        body: ListView(children: [
          GetBuilder<BookController>(
            init: BookController(),
            builder: (controller) {
              if (controller.loading == false) {
                return Center(
                  //height: 20,
                  child: Center(
                      child: CircularProgressIndicator(
                    color: Colors.black,
                  )),
                );
              } else
                return Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.all(7),
                          // padding: EdgeInsets.only(right: 5),

                          decoration: BoxDecoration(
                            color: Get.isDarkMode
                                ? Colors.white
                                : Colors.blue[100],
                            borderRadius: const BorderRadius.only(
                                bottomRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(30)),
                          ),
                          child: Directionality(
                              textDirection: _selectedLang == 'en'
                                  ? TextDirection.ltr
                                  : TextDirection.rtl,
                              child: SingleChildScrollView(
                                  child: TextButton(
                                onPressed: () {}, //=> Get.to(Bookbage(1)),
                                // "${post.name}".tr,

                                child: Text(
                                  "21".tr,
                                  style: TextStyle(
                                      //  fontSize: _drawerFontSize,
                                      color: Theme.of(context).accentColor),
                                ),
                              ))),
                          // )
                          //  ),
                        ),
                        SizedBox(
                          height: 40,
                          width: 120,
                          child: Container(
                              height: 200,
                              width: 100,
                              decoration: BoxDecoration(
                                color: Get.isDarkMode
                                    ? Colors.white
                                    : Colors.blue[100],
                                borderRadius: const BorderRadius.only(
                                    bottomRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(10)),
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  // dashboard.changeTabIndex(1);
                                  //controller.loadBook(index);
                                  //Get.to(DitalsCatogery());
                                },
                                child: Directionality(
                                  textDirection: _selectedLang == 'en'
                                      ? TextDirection.ltr
                                      : TextDirection.rtl,
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(7.0),
                                        child: Text(
                                          "20".tr,
                                          style: TextStyle(
                                              //  fontSize: _drawerFontSize,
                                              color: Theme.of(context)
                                                  .accentColor),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () => Get.to(Bookbage(1)),
                                        icon: Icon(Icons.more_horiz),

                                        //  fontSize: _drawerFontSize,
                                        color: Theme.of(context).accentColor,

                                        iconSize: 30,
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                        ),
                        //)
                      ],
                    ),
                    Container(
                        height: 170,
                        child: Directionality(
                            textDirection: _selectedLang == 'en'
                                ? TextDirection.rtl
                                : TextDirection.ltr,
                            child: GetBuilder<BookController>(
                                init: BookController(),
                                builder: (controller) {
                                  return ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemCount: controller.bookList.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        BookCategory book =
                                            controller.bookList[index];
                                        // Book booklis = book.book![index];
                                        //Text('${booklis.name}');
                                        //Book book = post.book![index];
                                        return Container(
                                          margin: const EdgeInsets.all(7),
                                          //  height: 180,
                                          width: 105,
                                          padding: EdgeInsets.all(3),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(10)),
                                            boxShadow: [
                                              BoxShadow(
                                                // color: Colors.blue[300],
                                                //color: Color(0xFFBBDEFB),
                                                color: Color(0xFF508D9B),
                                                spreadRadius: 1,
                                                blurRadius: 5,
                                                // offset: Offset(8,
                                                //     5), // changes position of shadow
                                              ),
                                            ],
                                          ),
                                          child: Column(
                                            children: [
                                              Container(
                                                width: double.infinity,
                                                height: 105,
                                                padding: EdgeInsets.zero,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                child: Image.asset(
                                                  'images/books_pile.PNG',
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 4,
                                              ),
                                              //SizedBox(height: 5,),

                                              Row(
                                                children: [
                                                  Container(
                                                    width: 90,
                                                    child:
                                                        SingleChildScrollView(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      reverse: true,
                                                      child: Directionality(
                                                        textDirection:
                                                            _selectedLang ==
                                                                    'en'
                                                                ? TextDirection
                                                                    .rtl
                                                                : TextDirection
                                                                    .ltr,
                                                        child: Text(
                                                          //'${book.name}',
                                                          "${book.name}",
                                                          style: TextStyle(
                                                            //  fontSize: _drawerFontSize,
                                                            color: Theme.of(
                                                                    context)
                                                                .accentColor,
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  // IconButton(
                                                  //     onPressed: () {},
                                                  //     icon: Icon(Icons.favorite))
                                                ],
                                              ),

                                              Divider(
                                                color: Colors.black,
                                                height: 10,
                                              ),
                                            ],
                                          ),
                                        );
                                        //});
                                      });
                                }))),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.all(7),
                          // padding: EdgeInsets.only(right: 5),

                          decoration: BoxDecoration(
                            color: Get.isDarkMode
                                ? Colors.white
                                : Colors.blue[100],
                            borderRadius: const BorderRadius.only(
                                bottomRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(30)),
                          ),
                          child: Directionality(
                              textDirection: _selectedLang == 'en'
                                  ? TextDirection.ltr
                                  : TextDirection.rtl,
                              child: SingleChildScrollView(
                                child: TextButton(
                                  onPressed: () {}, // => Get.to(Bookbage(1)),
                                  // "${post.name}".tr,

                                  child: Text("22".tr,
                                      style: TextStyle(
                                        //  fontSize: _drawerFontSize,
                                        color: Theme.of(context).accentColor,

                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      )),
                                ),
                              )),
                          // )
                          //  ),
                        ),
                        SizedBox(
                          height: 40,
                          width: 120,
                          child: Container(
                              height: 200,
                              width: 100,
                              decoration: BoxDecoration(
                                color: Get.isDarkMode
                                    ? Colors.white
                                    : Colors.blue[100],
                                borderRadius: const BorderRadius.only(
                                    bottomRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(10)),
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  // dashboard.changeTabIndex(1);
                                  //controller.loadBook(index);
                                  //Get.to(DitalsCatogery());
                                },
                                child: Directionality(
                                  textDirection: _selectedLang == 'en'
                                      ? TextDirection.ltr
                                      : TextDirection.rtl,
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(7.0),
                                        child: Text(
                                          "20".tr,
                                          style: TextStyle(
                                            //  fontSize: _drawerFontSize,
                                            color:
                                                Theme.of(context).accentColor,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () => Get.to(Ebookbage(1)),
                                        icon: Icon(Icons.more_horiz),
                                        color: Theme.of(context).accentColor,
                                        iconSize: 30,
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                        ),
                        //)
                      ],
                    ),
                    Container(
                        height: 170,
                        child: Directionality(
                            textDirection: _selectedLang == 'en'
                                ? TextDirection.rtl
                                : TextDirection.ltr,
                            child: GetBuilder<EbookController>(
                                init: EbookController(),
                                builder: (controller) {
                                  return ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemCount: controller.ebookList.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        CategoryEBook eBook =
                                            controller.ebookList[index];
                                        //EBook eBooklis = eBook.ebook![index];
                                        // EBook ebooks = eBook.ebook[index];
                                        //Book book = post.book![index];
                                        return Container(
                                          margin: const EdgeInsets.all(7),
                                          //  height: 180,
                                          width: 105,
                                          padding: EdgeInsets.all(3),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(10)),
                                            boxShadow: [
                                              BoxShadow(
                                                // color: Colors.blue[300],
                                                //color: Color(0xFFBBDEFB),
                                                color: Color(0xFF508D9B),
                                                spreadRadius: 1,
                                                blurRadius: 5,
                                                // offset: Offset(8,
                                                //     5), // changes position of shadow
                                              ),
                                            ],
                                          ),
                                          child: Column(
                                            children: [
                                              Container(
                                                width: double.infinity,
                                                height: 100,
                                                padding: EdgeInsets.zero,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Image.asset(
                                                  'images/books_pile.PNG',
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 4,
                                              ),
                                              //SizedBox(height: 5,),

                                              Row(
                                                children: [
                                                  Container(
                                                    width: 90,
                                                    child:
                                                        SingleChildScrollView(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      //reverse: true,
                                                      child: Directionality(
                                                        textDirection:
                                                            _selectedLang ==
                                                                    'en'
                                                                ? TextDirection
                                                                    .rtl
                                                                : TextDirection
                                                                    .ltr,
                                                        child: Text(
                                                          //'${book.name}',
                                                          "${eBook.name}",
                                                          style: TextStyle(
                                                            //  fontSize: _drawerFontSize,
                                                            color: Theme.of(
                                                                    context)
                                                                .accentColor,

                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  // IconButton(
                                                  //     onPressed: () {},
                                                  //     icon: Icon(Icons.favorite))
                                                ],
                                              ),

                                              Divider(
                                                color: Colors.black,
                                                height: 10,
                                              ),
                                            ],
                                          ),
                                        );
                                        //});
                                      });
                                }))),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.all(7),
                          // padding: EdgeInsets.only(right: 5),

                          decoration: BoxDecoration(
                            color: Get.isDarkMode
                                ? Colors.white
                                : Colors.blue[100],
                            borderRadius: const BorderRadius.only(
                                bottomRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(30)),
                          ),
                          child: Directionality(
                              textDirection: _selectedLang == 'en'
                                  ? TextDirection.ltr
                                  : TextDirection.rtl,
                              child: SingleChildScrollView(
                                child: TextButton(
                                  onPressed: () {}, // => Get.to(Bookbage(1)),
                                  // "${post.name}".tr,

                                  child: Text("23".tr,
                                      style: TextStyle(
                                        //  fontSize: _drawerFontSize,
                                        color: Theme.of(context).accentColor,

                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      )),
                                ),
                              )),
                          // )
                          //  ),
                        ),
                        SizedBox(
                          height: 40,
                          width: 120,
                          child: Container(
                              height: 200,
                              width: 100,
                              decoration: BoxDecoration(
                                color: Get.isDarkMode
                                    ? Colors.white
                                    : Colors.blue[100],
                                borderRadius: const BorderRadius.only(
                                    bottomRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(10)),
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  // dashboard.changeTabIndex(1);
                                  //controller.loadBook(index);
                                  //Get.to(DitalsCatogery());
                                  // Get.to(Projectbage(1));
                                },
                                child: Directionality(
                                  textDirection: _selectedLang == 'en'
                                      ? TextDirection.ltr
                                      : TextDirection.rtl,
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(7.0),
                                        child: Text(
                                          "20".tr,
                                          style: TextStyle(
                                            //  fontSize: _drawerFontSize,
                                            color:
                                                Theme.of(context).accentColor,

                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      IconButton(
                                        // onPressed: () => Get.to(Ebookbage()),
                                        onPressed: () {
                                          Get.to(Projectbage(Projectbage(1)));
                                        },
                                        icon: Icon(Icons.more_horiz),
                                        //  fontSize: _drawerFontSize,
                                        color: Theme.of(context).accentColor,

                                        iconSize: 30,
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                        ),
                        //)
                      ],
                    ),
                    Container(
                        height: 170,
                        child: Directionality(
                            textDirection: _selectedLang == 'en'
                                ? TextDirection.rtl
                                : TextDirection.ltr,
                            child: GetBuilder<ProjectController>(
                                init: ProjectController(),
                                builder: (controller) {
                                  return ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemCount: controller.projectList.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        ProjectCategory project =
                                            controller.projectList[index];

                                        Text(
                                          '${project.name}',
                                          style: TextStyle(
                                              //  fontSize: _drawerFontSize,
                                              color: Theme.of(context)
                                                  .accentColor),
                                        );
                                        //Book book = post.book![index];
                                        return Container(
                                          margin: const EdgeInsets.all(7),
                                          //  height: 180,
                                          width: 105,
                                          padding: EdgeInsets.all(3),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(10)),
                                            boxShadow: [
                                              BoxShadow(
                                                // color: Colors.blue[300],
                                                //color: Color(0xFFBBDEFB),
                                                color: Color(0xFF508D9B),
                                                spreadRadius: 1,
                                                blurRadius: 5,
                                                // offset: Offset(8,
                                                //     5), // changes position of shadow
                                              ),
                                            ],
                                          ),
                                          child: Column(
                                            children: [
                                              Container(
                                                width: double.infinity,
                                                height: 100,
                                                padding: EdgeInsets.zero,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Image.asset(
                                                  'images/books_pile.PNG',
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 4,
                                              ),
                                              //SizedBox(height: 5,),

                                              Row(
                                                children: [
                                                  Container(
                                                    width: 90,
                                                    child:
                                                        SingleChildScrollView(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      //reverse: true,
                                                      child: Directionality(
                                                        textDirection:
                                                            _selectedLang ==
                                                                    'en'
                                                                ? TextDirection
                                                                    .rtl
                                                                : TextDirection
                                                                    .ltr,
                                                        child: Text(
                                                          //'${book.name}',
                                                          "${project.name}",
                                                          style: TextStyle(
                                                            //  fontSize: _drawerFontSize,
                                                            color: Theme.of(
                                                                    context)
                                                                .accentColor,

                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  // IconButton(
                                                  //     onPressed: () {},
                                                  //     icon: Icon(Icons.favorite))
                                                ],
                                              ),

                                              Divider(
                                                color: Colors.black,
                                                height: 10,
                                              ),
                                            ],
                                          ),
                                        );
                                        //});
                                      });
                                }))),
                  ],
                );
            },
          ),
        ]));

//    );
  }
}
