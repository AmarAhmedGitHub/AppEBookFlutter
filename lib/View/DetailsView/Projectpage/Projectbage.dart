import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:library/Controler/home/ProjectController.dart';
import 'package:library/Model/ProjectModel/CategoryProject.dart';
import 'package:library/View/DetailsView/Projectpage/Projectpage.dart';
import 'package:library/View/DetailsView/Projectpage/Serch.dart';
import 'package:library/View/dashboard/dashboard_page.dart';
import 'package:library/View/widgets/Appbar/view_drawer/drawer_common.dart';
import 'package:library/utls/api/constant.dart';
import 'package:library/utls/api/user_service.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

// ignore: must_be_immutable
class Projectbage extends StatefulWidget {
  final indx;

  Projectbage(this.indx);
  @override
  _Projectbage createState() => _Projectbage();
}

class _Projectbage extends State<Projectbage> {
  ProjectController projectController = Get.put(ProjectController());
  String progress = '0';
  double progress2 = 0;

  Future download2(String name, String path) async {
    Dio dio = Dio();
    try {
      String token = await getToken();
      final response = await dio.post(
        downlodURL,

        //downlodUR,L
        data: {'path': path},
        onReceiveProgress: (received, total) {
          if (total != -1) {
            print((received / total * 100).toStringAsFixed(0) + "%");
          }
          setState(() {
            progress = (received / total * 100).toStringAsFixed(0);
            progress2 = (received / total * 100) / 100;
          });

          if (progress == '100') {}
        },

        options: Options(
            headers: {
              'Accept': 'application/json',
              'Authorization': 'Bearer $token'
            },
            responseType: ResponseType.bytes,
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            }),
      );
      // print(response);
      //print(response.headers);
      switch (response.statusCode) {
        case 200:
          print('sssss');
          print(response);
          String dir = '';
          if (Platform.isAndroid) {
            dir = '/sdcard/download/';
            print('object');
          } else {
            dir = (await getApplicationDocumentsDirectory()).path;
          }
          File file = new File(dir + '/' + name + '.pdf');
          // if (!await file.exists()) {
          //   await file.create();
          // }
          // await file.writeAsBytes(response.data);

          var raf = file.openSync(mode: FileMode.write);
          // response.data is List<int> type
          raf.writeFromSync(response.data);
          await raf.close();
          break;
        case 401:
          print('unauthorized');
          break;
        default:
          print(response.data);
          print('somethingWentWrong mm');
          break;
      }
    } catch (e) {
      print(e);
    }
  }

  DashboardPage dashboardPage = Get.put(DashboardPage());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //    RoundAppBar(title: 'book',),
        drawer: DrawerHome(),
        appBar: AppBar(
          backgroundColor: Color(0xFF5A8DEE),
          title: Center(
              child: Text(
            '50'.tr,
            style: TextStyle(
                //  fontSize: _drawerFontSize,
                color: Theme.of(context).accentColor),
          )),
          actions: [
            //IconButton(onPressed: () {}, icon: Icon(Icons.search)),
            //  IconButton(onPressed: () {}, icon: Icon(Icons.search)),
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  showSearch(
                      context: context,
                      delegate: DataSearch(list: projectController.project));
                }) // IconButton(onPressed: () {}, icon: Icon(Icons.shopping_cart_outlined)),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(10.0),
            ),
          ),
//      actions: [Icon(Icons.dehaze)],
        ),
        //  AppBar(
        //   title: Text('30'.tr),
        // ),
        body: GetBuilder<ProjectController>(builder: (controller) //=>
            {
          ProjectCategory projectpost =
              controller.projectList[controller.indexCateg];
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
                    itemCount: controller.projectList.length,
                    //.length, //categoriescontroller.categories_all.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      //             BookCategory post = controller.bookList[index];
                      ProjectCategory projectpost =
                          controller.projectList[index];
                      return InkWell(
                        onTap: () {
                          controller.loadProject(index);
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
                              '${projectpost.name}',
                              style: TextStyle(
                                  //  fontSize: _drawerFontSize,
                                  color: Theme.of(context).accentColor),
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
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                      shrinkWrap: false,
                      dragStartBehavior: DragStartBehavior.down,
                      //reverse: true,
                      physics: const ScrollPhysics(),
                      itemCount: projectpost.project!.length,
                      //.length, //categoriescontroller.categories_all.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        Project project = projectpost.project![index];

                        if (controller.project.length == 0) {
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
                                                      '${project.name}', //+ book!.name!
                                                      style: TextStyle(
                                                          //  fontSize: _drawerFontSize,
                                                          color:
                                                              Theme.of(context)
                                                                  .accentColor),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                child: Row(
                                                  children: <Widget>[
                                                    Text(
                                                      "${project.supervisor}", //+ book!.name!
                                                      style: TextStyle(
                                                          //  fontSize: _drawerFontSize,
                                                          color:
                                                              Theme.of(context)
                                                                  .accentColor),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                child: Row(
                                                  children: <Widget>[
                                                    Text(
                                                      '', //+ book!.name!
                                                      style: TextStyle(
                                                          //  fontSize: _drawerFontSize,
                                                          color:
                                                              Theme.of(context)
                                                                  .accentColor),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: <Widget>[
                                                    IconButton(
                                                        onPressed: () {},
                                                        icon: Icon(
                                                            Icons.favorite)),
                                                    IconButton(
                                                        onPressed: () {},
                                                        icon: Icon(
                                                            Icons.download)),
                                                    IconButton(
                                                        onPressed: () {},
                                                        icon: Icon(Icons
                                                            .local_library)),
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
                              Get.to(ReadProject(project, projectpost.name!));
                            },
                          );
                        }
                      })),
            ],
          );
        }));
// ] );
  }
}
