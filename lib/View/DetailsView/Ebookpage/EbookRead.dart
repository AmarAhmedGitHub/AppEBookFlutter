import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:library/Controler/FavoriteListController/FavController.dart';
import 'package:library/Model/EBookModel/EBookModel.dart';
import 'package:library/utls/api/constant.dart';
import 'package:library/utls/api/user_service.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

class ReadEbook extends StatefulWidget {
  final EBook infoEbook;
  ReadEbook(this.infoEbook);

  //List<Book> contacts;
  //ReadBook(List<Book> this.contacts, {Key? key}) : super(key: key);

  @override
  _ReadEbookState createState() => _ReadEbookState();
}

var dio = Dio();

class _ReadEbookState extends State<ReadEbook> {
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

  FavController favController = Get.put(FavController());

  bool? selctinfo;

  selectFavetoryEbook() {
    setState(() {
      favController.checkBoo(
        widget.infoEbook.id!,
      );

      if (favController.selectedbook == true) {
        selctinfo = true;
      } else {
        selctinfo = false;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    selectFavetoryEbook();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            '41'.tr,
            style: TextStyle(
                //  fontSize: _drawerFontSize,
                color: Theme.of(context).accentColor),
          ),
          leading: GestureDetector(
            onTap: () {
              // Navigator.of(context).pushReplacementNamed('/homePage');
              //Get.to(FavoriteModle());
            },
            child: Icon(
              Icons.arrow_back, // add custom icons also
            ),
          ),
        ),
        body: ListView.builder(
            itemCount: 1, //_listController
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return
                  // if (widget.test == 1) {
                  Column(
                children: [
                  Container(
                    // margin: EdgeInsets.all(4),
                    padding: EdgeInsets.all(10),
                    // color: Colors.blue[100],
                    child: Column(
                      children: [
                        Container(
                            width: 400,
                            height: 300,
                            child: Column(
                              children: [
                                Container(
                                  child: Expanded(
                                    flex: 3,
                                    child: widget.infoEbook.image != null
                                        ? Image.network(
                                            'http://192.168.0.191:8000/storage/ebook/' +
                                                widget.infoEbook.image!)
                                        : Image.asset("images/books_pile.PNG"),
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      GetBuilder<FavController>(
                                          builder: (controller) {
                                        return InkWell(
                                          onTap: () {
                                            setState(() {
                                              if (selctinfo == true) {
                                                favController.deleteFaveorte(
                                                  widget.infoEbook.id!,
                                                );
                                              } else {
                                                favController.insrtEbook(
                                                    widget.infoEbook.id!,
                                                    widget.infoEbook);
                                                selctinfo = true;
                                              }
                                            });
                                          },
                                          child: selctinfo == true
                                              ? Icon(
                                                  Icons.favorite,
                                                  color: Colors.red,
                                                  size: 35,
                                                )
                                              : Icon(
                                                  Icons.favorite_border,
                                                  size: 35,
                                                ),
                                        );
                                      }),
                                      InkWell(
                                        child: progress2 != 0
                                            ? IconButton(
                                                onPressed: () async {
                                                  download2(
                                                      widget.infoEbook.name!,
                                                      widget.infoEbook.path!);
                                                },
                                                icon: Icon(Icons.download))
                                            : CircularProgressIndicator(
                                                value: progress2,
                                              ),
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
                      height: MediaQuery.of(context).size.height,
                      child: ListView(
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
                              "42".tr +
                                  "${widget.infoEbook.name} ", //+ book!.name!
                              style: TextStyle(
                                  //  fontSize: _drawerFontSize,
                                  color: Theme.of(context).accentColor),
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
                              "43".tr +
                                  "${widget.infoEbook.issn} ", //+ book!.name!
                              style: TextStyle(
                                  //  fontSize: _drawerFontSize,
                                  color: Theme.of(context).accentColor),
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
                              "44".tr +
                                  "${widget.infoEbook.language} ", //+ book!.name!
                              style: TextStyle(
                                  //  fontSize: _drawerFontSize,
                                  color: Theme.of(context).accentColor),
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
                              "45".tr +
                                  "${widget.infoEbook.author} ", //+ book!.name!
                              style: TextStyle(
                                  //  fontSize: _drawerFontSize,
                                  color: Theme.of(context).accentColor),
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
                              "46".tr +
                                  "${widget.infoEbook.publisher} ", //+ book!.name!
                              style: TextStyle(
                                  //  fontSize: _drawerFontSize,
                                  color: Theme.of(context).accentColor),
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
                              "47".tr +
                                  "${widget.infoEbook.yaer} ", //+ book!.name!
                              style: TextStyle(
                                  //  fontSize: _drawerFontSize,
                                  color: Theme.of(context).accentColor),
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
