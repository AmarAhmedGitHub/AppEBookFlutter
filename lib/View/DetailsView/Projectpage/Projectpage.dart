import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:library/Controler/FavoriteListController/FavController.dart';
import 'package:library/Model/ProjectModel/CategoryProject.dart';
import 'package:library/utls/api/Order.dart';
import 'package:library/utls/api/constant.dart';
import 'package:library/utls/api/user_service.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

class ReadProject extends StatefulWidget {
  final Project infoProject;
  final String namecate;
  ReadProject(this.infoProject, this.namecate);
  //List<Book> contacts;
  //ReadBook(List<Book> this.contacts, {Key? key}) : super(key: key);

  @override
  _ReadProjectState createState() => _ReadProjectState();
}

class _ReadProjectState extends State<ReadProject> {
  //FavController favController = Get.put(FavController());
//  HomeController homeController = Get.put(HomeController());
  FavController favController = Get.put(FavController());
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

  late bool selectinfo;

  selectfav() {
    setState(() {
      favController.checkBoo(widget.infoProject.id!);

      if (favController.selectedbook == true) {
        selectinfo = true;
        print("Exist");
      } else {
        selectinfo = false;
        print("Notfound");
      }
    });
  }
  // if (favController.selected == true) {
  //   selectinfo = false;
  //   print("Exist");
  // } else {
  //   selectinfo = true;
  //   print("Notfound");
  // }

  @override
  void initState() {
    selectfav();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            '51'.tr,
            style: TextStyle(
                //  fontSize: _drawerFontSize,
                color: Theme.of(context).accentColor),
          ),
          leading: GestureDetector(
            onTap: () {
              // Navigator.of(context).pushReplacementNamed('/homePage');
              //Get.to(FavoriteModle());
              Get.back();
            },
            child: Icon(
              Icons.arrow_back,
              //  fontSize: _drawerFontSize,
              color: Theme.of(context).accentColor,
            ),
          ),
        ),
        body: ListView.builder(
            itemCount: 1, //_listController
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Container(
                            width: 400,
                            height: 300,
                            // height: MediaQuery.of(context).size.height,
                            child: Column(
                              children: [
                                Container(
                                  child: Expanded(
                                    flex: 3,
                                    child: widget.infoProject.image != null
                                        ? Image.network(
                                            'http://192.168.0.191:8000/storage/ebook/' +
                                                widget.infoProject.image!)
                                        : Image.asset("images/books_pile.PNG"),
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      InkWell(
                                        onTap: () {
                                          if (selectinfo == true) {
                                            favController.deletProjec(
                                                widget.infoProject.id!,
                                                widget.infoProject);
                                          } else {
                                            favController.insrtProjec(
                                                widget.infoProject.id!,
                                                widget.infoProject);
                                          }
                                        },
                                        child: selectinfo == true
                                            ? Icon(
                                                Icons.favorite,
                                                color: Colors.red,
                                                size: 35,
                                              )
                                            : Icon(
                                                Icons.favorite_border,
                                                size: 35,
                                              ),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            requestBorrwn(
                                                widget.infoProject.name!,
                                                '${widget.infoProject.id}',
                                                '${widget.namecate}',
                                                '1');
                                          },
                                          icon: Icon(
                                              Icons.local_library_rounded)),
                                      progress2 != 0
                                          ? IconButton(
                                              onPressed: () async {
                                                download2(
                                                    widget.infoProject.name!,
                                                    widget.infoProject.path!);
                                              },
                                              icon: Icon(Icons.download))
                                          : CircularProgressIndicator(
                                              value: progress2,
                                            ),
                                    ],
                                  ),
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.black,
                    indent: 20,
                    endIndent: 20,
                    thickness: 2,
                    height: 0,
                  ),
                  Container(
                      alignment: Alignment.topLeft,
                      //  margin: EdgeInsets.all(2),
                      padding: EdgeInsets.only(
                        left: 20,
                      ),
                      //  color: Colors.blue[100],
                      width: double.infinity,
                      height: 300,
                      child: Column(
                        //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                        children: <Widget>[
                          Container(
                            width: double.infinity,
                            margin: EdgeInsets.only(top: 7, right: 20),
                            padding: EdgeInsets.only(top: 7, left: 7),
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  spreadRadius: 1,
                                  blurRadius: 1,
                                ),
                              ],
                            ),
                            child: Text(
                              "52".tr +
                                  "${widget.infoProject.name} ", //+ book!.name!
                              style: TextStyle(
                                  //  fontSize: _drawerFontSize,
                                  color: Theme.of(context).accentColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            margin: EdgeInsets.only(top: 7, right: 20),
                            padding: EdgeInsets.only(top: 7, left: 7),
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white,
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
                            child: Text(
                              "53".tr +
                                  "${widget.infoProject.language} ", //+ book!.name!
                              style: TextStyle(
                                  //  fontSize: _drawerFontSize,
                                  color: Theme.of(context).accentColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            margin: EdgeInsets.only(top: 7, right: 20),
                            padding: EdgeInsets.only(top: 7, left: 7),
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  spreadRadius: 1,
                                  blurRadius: 1,
                                ),
                              ],
                            ),
                            child: Text(
                              "54".tr +
                                  "${widget.infoProject.supervisor} ", //+ book!.name!
                              style: TextStyle(
                                  //  fontSize: _drawerFontSize,
                                  color: Theme.of(context).accentColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            margin: EdgeInsets.only(top: 7, right: 20),
                            padding: EdgeInsets.only(
                              top: 7,
                              left: 7,
                            ),
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  spreadRadius: 1,
                                  blurRadius: 1,
                                ),
                              ],
                            ),
                            child: Text(
                              "55".tr +
                                  "${widget.infoProject.quantity} ", //+ book!.name!
                              style: TextStyle(
                                  //  fontSize: _drawerFontSize,
                                  color: Theme.of(context).accentColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      )),
                ],
              );
//              });
            }));
  }
}
