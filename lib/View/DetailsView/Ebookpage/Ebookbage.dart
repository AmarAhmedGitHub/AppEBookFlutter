import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:library/Controler/home/EbookController.dart';
import 'package:library/Model/EBookModel/EBookModel.dart';
import 'package:library/View/DetailsView/Ebookpage/EbookRead.dart';
import 'package:library/View/DetailsView/Ebookpage/Serch.dart';
import 'package:library/View/dashboard/dashboard_page.dart';
import 'package:library/View/widgets/Appbar/view_drawer/drawer_common.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class Ebookbage extends GetView<EbookController> {
  final int id;
  Ebookbage(this.id);

  DashboardPage dashboardPage = Get.put(DashboardPage());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: DrawerHome(),
        appBar: AppBar(
          backgroundColor: Color(0xFF5A8DEE),
          title: Center(child: Text('40'.tr)),
          actions: [
            IconButton(
                icon: Icon(Icons.search, color: Theme.of(context).accentColor),
                onPressed: () {
                  showSearch(
                      context: context,
                      delegate: DataSearch(list: controller.Ebook));
                })
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(10.0),
            ),
          ),
        ),
        body: GetBuilder<EbookController>(builder: (controller) //=>
            {
          CategoryEBook ebookpost = controller.ebookList[controller.indexCateg];
          return ListView(
            children: [
              Container(
                height: 50.0,
                margin: const EdgeInsets.only(top: 10, bottom: 6),
                child: ListView.builder(
                    shrinkWrap: false,
                    dragStartBehavior: DragStartBehavior.down,
                    reverse: true,
                    physics: const ScrollPhysics(),
                    itemCount: controller.ebookList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      CategoryEBook ebookpost = controller.ebookList[index];

                      if (controller.ebookList.length == 0) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return InkWell(
                          onTap: () {
                            controller.loadEBook(index);
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
                                ),
                              ],
                            ),
                            margin:
                                EdgeInsets.only(top: 8, right: 20, bottom: 8),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 1.0,
                              vertical: 1.0,
                            ),
                            child: ChoiceChip(
                              backgroundColor: Colors.white,
                              label: Text(
                                '${ebookpost.name}',
                                style: TextStyle(
                                    color: Theme.of(context).accentColor),
                              ), //'${post.name}'),

                              selected: controller.indexCateg == index,
                            ),
                          ),
                        );
                      }
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
                    //reverse: true,
                    physics: const ScrollPhysics(),
                    itemCount: ebookpost.ebook!.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      EBook ebook = ebookpost.ebook![index];
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
                                color: Colors.black12,
                                spreadRadius: 1,
                                blurRadius: 1,
                              ),
                            ],
                          ),
                          child: Card(
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 2,
                                  child: // book.image != null
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
                                                  '${ebook.name}', //+ book!.name!
                                                  style: TextStyle(
                                                      //  fontSize: _drawerFontSize,
                                                      color: Theme.of(context)
                                                          .accentColor),
                                                )
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Row(
                                              children: <Widget>[
                                                Text(
                                                  "${ebook.publisher}", //+ book!.name!
                                                  style: TextStyle(
                                                      //  fontSize: _drawerFontSize,
                                                      color: Theme.of(context)
                                                          .accentColor),
                                                )
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Row(
                                              children: <Widget>[
                                                Text(
                                                  '${ebook.author}', //+ book!.name!
                                                  style: TextStyle(
                                                      //  fontSize: _drawerFontSize,
                                                      color: Theme.of(context)
                                                          .accentColor),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: <Widget>[
                                                IconButton(
                                                    onPressed: () {},
                                                    icon: Icon(Icons.download)),
                                                IconButton(
                                                    onPressed: () {},
                                                    icon: Icon(
                                                        Icons.favorite_border)),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ),
                        onTap: () {
                          Get.to(ReadEbook(ebook));
                        },
                      );
                    }),
              ),
            ],
          );
        }));
// ] );
  }
}

//DashboardController dashboard = Get.put(DashboardController());
// EbookController controllers = Get.put(EbookController());
// Container buildCategoriesRow() {
//   return Container(
//       // color: Colors.lightBlue,
//       height: 50.0,
//       margin: EdgeInsets.only(top: 13, bottom: 13),
//       child: ListView.builder(
//           shrinkWrap: true,
//           dragStartBehavior: DragStartBehavior.down,
//           reverse: true,
//           physics: ScrollPhysics(),
//           itemCount: controllers
//               .ebookList.length, //categoriescontroller.categories_all.length,
//           scrollDirection: Axis.horizontal,
//           itemBuilder: (context, index) =>
//               GetBuilder<EbookController>(builder: (controller) {
//                 CategoryEBook ebookpost = controller.ebookList[index];
//                 //int selectIndex = controller.shawindex;
//                 //BookCategory post = controller.postList[selectindex];
//                 // if (categoriescontroller.loading.value)
//                 //   return Center(child: CircularProgressIndicator());
//                 // if (categoriescontroller.categories_all.isEmpty) {
//                 //   return Center(child: Text("No categories found"));
//                 // }
//                 return InkWell(
//                   onTap: () {
//                     controller.loadEBook(index);
//                     // Get.to(DitalsCatogery());
//                     dashboard.changeTabIndex(2);
//                   },
//                   child: Container(
//                     width: 90,
//                     margin: EdgeInsets.only(top: 8, right: 4, bottom: 8),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(15.15),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.lightBlue,
//                           blurRadius: 8,
//                         ),
//                       ],
//                       color: index == controller.indexCateg
//                           ? Colors.lightBlue
//                           : Colors.white70,
//                     ),
//                     padding: EdgeInsets.symmetric(
//                       horizontal: 16.0,
//                       vertical: 8.0,
//                     ),
//                     child: Text(
//                       "${ebookpost.name}",
//                       style: TextStyle(
//                           // color: index == controller.currentIndex
//                           //     ? Colors.white
//                           //     : Colors.black,
//                           ),
//                     ),
//                   ),
//                 );
//               })));
//   //);
// }
