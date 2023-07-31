import 'package:flutter/material.dart';
import 'package:library/View/DetailsView/Bookpage/Bookbage.dart';
import 'package:library/View/DetailsView/Ebookpage/Ebookbage.dart';
import 'package:library/View/DetailsView/Projectpage/Projectbage.dart';
import 'package:library/View/widgets/Appbar/view_drawer/drawer_common.dart';
import 'package:get/get.dart';

class Section extends StatefulWidget {
  const Section({Key? key}) : super(key: key);
  @override
  _SectionState createState() => _SectionState();
}

class _SectionState extends State<Section> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF5A8DEE),
        title: Center(child: Text('Section Library ')),
        actions: [],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10.0),
          ),
        ),
//      actions: [Icon(Icons.dehaze)],
      ),
      drawer: DrawerHome(),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.only(top: 70),
            alignment: Alignment.center,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.all(10),
                          //  color: Colors.red,

                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            image: DecorationImage(
                                image: AssetImage("images/logos.PNG"),
                                // opacity: 0.4,
                                fit: BoxFit.fill),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                spreadRadius: 1,
                                blurRadius: 1,
                              ),
                            ],
                          ),
                          child: Text(
                            "E_book",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                        onTap: () {
                          //print("Tapped on container");
                          Get.to(Ebookbage(1));
                        },
                      ),
                      InkWell(
                        child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.all(10),

                          //color: Colors.red,
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            image: DecorationImage(
                              image: AssetImage("images/logos.PNG"),
                              fit: BoxFit.fill,
                              //opacity: 0.4
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                spreadRadius: 1,
                                blurRadius: 1,
                              ),
                            ],
                          ),
                          child: Text(
                            "Book",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                        onTap: () {
                          //print("Tapped on container");
                          Get.to(Bookbage(1));
                        },
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      child: Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.all(10),
                        //color: Colors.red,
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          image: DecorationImage(
                            image: AssetImage("images/logos.PNG"),
                            fit: BoxFit.fill,
                            //opacity: 0.4
                          ),
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
                          "Project",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      onTap: () {
                        //print("Tapped on container");
                        Get.to(Projectbage(1));
                      },
                    ),
                    InkWell(
                      child: Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.all(10),
                        //color: Colors.red,
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          image: DecorationImage(
                            image: AssetImage("images/logos.PNG"),
                            fit: BoxFit.fill,
                            //opacity: 0.4
                          ),
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
                          "New ",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      onTap: () {
                        print("Tapped on container");
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
