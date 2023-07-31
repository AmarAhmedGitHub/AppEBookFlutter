import 'package:library/utls/api/Order.dart';
import 'package:flutter/material.dart';
import 'package:library/Controler/FavoriteListController/FavController.dart';
import 'package:library/Controler/home/homecontroller.dart';
import 'package:library/Model/BookModle/BookModle.dart';
import 'package:get/get.dart';
//import 'package:permission_handler/permission_handler.dart';

// ignore: must_be_immutable
class ReadBook extends StatefulWidget {
  final Book infobook;
  final String namecat;
  ReadBook(this.infobook, this.namecat);
  //List<Book> contacts;
  //ReadBook(List<Book> this.contacts, {Key? key}) : super(key: key);

  @override
  _ReadBookState createState() => _ReadBookState();
}

class _ReadBookState extends State<ReadBook> {
  //final bool selectedinfo ;
  //HomeController homeController = Get.put(HomeController());
  FavController favController = Get.put(FavController());

  int selctbrwo = 0;

  selectFavetory() {
    // setState(() {
    print('selctfaveroty');
 favController.checkBoo(widget.infobook.id!);
 print('fi');
      if(favController.fi<=0){
selctbrwo = 0;
      }else{
        selctbrwo = 1;
      }
    //favController.fi == 2;
   
     //print('iiii');
     //print(favController.fi);
    if (favController.selectedbook.value == true) {
      
     
     
    }

    //   if (favController.selectedbook.value == true) {
    //     selctbrwo = true;
    //     print("Exist");
    //   } else {
    //     selctbrwo = false;
    //     print("Notfound");
    //   }
    // });
  }

  @override
  void initState() {
    super.initState();
    selectFavetory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('30'.tr),
          leading: GestureDetector(
            onTap: () {
              // Navigator.of(context).pushReplacementNamed('/homePage');
              //Get.to(FavoriteModle());
              Get.back();
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
                                    child: widget.infobook.image != null
                                        ? Image.network(
                                            'http://192.168.0.191:8000/storage/ebook/' +
                                                widget.infobook.image!)
                                        : Image.asset("images/books_pile.PNG"),
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      GetBuilder<FavController>(
                                          init: FavController(),
                                          builder: (controller) {
                                            return InkWell(
                                              onTap: () {
                                                if (selctbrwo == 0) {
                                                  selctbrwo = 1;
                                                } else {
                                                  selctbrwo = 0;
                                                }
                                                controller.checkBoo(
                                                    widget.infobook.id!);
                                                //  setState(() {
                                                // favController.checkBook(
                                                //     widget.infobook.id!,
                                                //     widget.infobook);
                                                if (controller
                                                        .selectedbook.value !=
                                                    true) {
                                                  // selctbrwo = 1;
                                                  controller.insrt(
                                                      widget.infobook.id!,
                                                      widget.infobook);
                                                  //selctbrwo = true;
                                                  print("insrt");
                                                } else {
                                                  //selctbrwo = 0;
                                                  controller.delet(
                                                      widget.infobook.id!,
                                                      widget.infobook);

                                                  print("delet");
                                                }
                                                //});
                                              },
                                              child:
                                                  //  controller
                                                  //             .selectedbook.value ==
                                                  //         true
                                                  selctbrwo == 1
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
                                      IconButton(
                                          onPressed: () {
                                            requestBorrwn(
                                                '${widget.infobook.id}',
                                                '${widget.infobook.name}',
                                                '${widget.namecat}',
                                                '0');
                                          },
                                          icon: Icon(
                                              Icons.local_library_rounded)),
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
                              "32".tr +
                                  "${widget.infobook.name}".tr, //+ book!.name!
                              style: TextStyle(
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
                              "33".tr +
                                  "${widget.infobook.issn} ", //+ book!.name!
                              style: TextStyle(
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
                              "34".tr +
                                  "${widget.infobook.author} ", //+ book!.name!
                              style: TextStyle(
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
                              "35".tr +
                                  "${widget.infobook.publisher} ", //+ book!.name!
                              style: TextStyle(
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
                              "36".tr +
                                  "${widget.infobook.language} ", //+ book!.name!
                              style: TextStyle(
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
                              "37".tr +
                                  "${widget.infobook.quantity} ", //+ book!.name!
                              style: TextStyle(
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
                              "38".tr +
                                  "${widget.infobook.yaer} ", //+ book!.name!
                              style: TextStyle(
                                  color: Theme.of(context).accentColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      )),
                ],
              );
              //});
            }));
  }
}

// var progress = "";
// var path = "No Data";
// var platformVersion = "Unknown";
// var _onPressed;
// late Directory externalDir;

// bool downloading = false;
// FavController favController = Get.put(FavController());
// Widget ScrollView(int dataReadId, String dataReadname, int check) {
//   return SingleChildScrollView(
//     child: Column(
//       children: <Widget>[
//         GetBuilder<ProjectController>(builder: (controller) {
//           return ClipPath(
//               child: Container(
//                   padding: EdgeInsets.only(top: 40),
//                   height: 380,
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     //color: Colors.white,
//                     gradient: LinearGradient(
//                       begin: Alignment.bottomLeft,
//                       end: Alignment.topRight,
//                       colors: [
//                         Color(0xFF0F2027),
//                         Color(0xFFC7ECF4),
//                         Color(0xFF1C5384),
//                       ],
//                     ),
//                   ),
//                   child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: <Widget>[
//                         Row(
//                           children: [
//    //                         GetBuilder<FavController>(builder: (controller) {

//      //                       })
//                           ],
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: <Widget>[
//                             Text(
//                               '',
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 30,
//                               ),
//                             ),
//                           ],
//                         ),
//                         Image.asset(
//                           'images/books_pile.PNG',
//                           // favoriteListController.Favorite[index].imgUrl,
//                           width: 200,
//                           fit: BoxFit.fitWidth,
//                         ),
//                         SizedBox(height: 10.0),
//                         Text(
//                           //"Part 1",
//                           "${widget.infobook.name}", // controller.list_categ[controller.shawindex].number,
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 20,
//                           ),
//                         ),
//                         Text(
//                           //"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
//                           "${dataReadname}", //  " controller.list_categ[controller.shawindex].desc",
//                           style: TextStyle(fontSize: 20, color: Colors.black),
//                         ),
//                       ])));
//         }),
//       ],
//     ),
//   );
// }
// // return IconButton(
// //                                 onPressed: () {
// //                                   controller.check(dataReadId,check);
// //                                   if (controller.selected != true) {
// //                                     print("Exist");
// //                                     controller.deletePerson(dataReadId, check);
// //                                   } else {
// //                                     print("Notfound");
// //                                     controller.insertBook(nameModle, check);
// //                                   }
// //                                 },
// //                                 icon: favController.selected == true
// //                                     ? //selectfav()
// //                                     //?
// //                                     Icon(
// //                                         Icons.favorite,
// //                                         color: Colors.red,
// //                                         size: 35,
// //                                       )
// //                                     : Icon(
// //                                         Icons.favorite_border,
// //                                         size: 35,
// //                                       ),
// //                               );
