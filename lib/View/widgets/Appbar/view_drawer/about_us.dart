import 'package:flutter/material.dart';

class About_us extends StatelessWidget {
  const About_us({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  // color: Colors.white,
//borderRadius: const BorderRadius.all(Radius.circular(10)),
                  image: DecorationImage(
                      image: AssetImage("images/1.jpg"),
                      //  opacity: 0.6,
                      fit: BoxFit.fill,
                      //opacity: 0.5
                      ),
                ),
                width: double.infinity,
                height: 700,
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        //   color: Colors.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        image: DecorationImage(
                          image: AssetImage("images/logos1.png"),
                          // opacity: 0.6,
                          fit: BoxFit.fill,
                        ),
                      ),
                      margin: EdgeInsets.only(top: 19),
                      width: 150,
                      height: 150,
                    ),
                    Container(
                      child: Column(
                        children: [
                          Text(
                            "AL-NASSER",
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          Text(
                            "DIGITAL LIBRARY :1.0",
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          Divider(
                            color: Colors.black,
                            indent: 70,
                            endIndent: 70,
                            thickness: 2,
                            height: 0,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Text(
                            "Digital Library helpes the univarcity students and the admen, which ,"
                            "The Digital Library brovides for student or the users show book , ",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                wordSpacing: 3,
                                height: 1.6),
                          ),
                          Divider(
                            color: Colors.black,
                            indent: 4,
                            endIndent: 4,
                            thickness: 2,
                            height: 20,
                          ),
                          Text(
                            "Developed By:",
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.black),
                          ),
                          Divider(
                            color: Colors.black,
                            indent: 120,
                            endIndent: 120,
                            thickness: 2,
                            height: 20,
                          ),
                          Text(
                            "Anwer solh",
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.black),
                          ),
                          Divider(
                            height: 8,
                          ),
                          Text(
                            "Arkan Shaalan",
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.black),
                          ),
                          Divider(
                            height: 8,
                          ),
                          Text(
                            "Amar AL-ghader",
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.black),
                          ),
                          Divider(
                            height: 8,
                          ),
                          Text(
                            "Zaher AL-ghader",
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.black),
                          ),
                          Divider(
                            height: 8,
                          ),
                          Text(
                            "Kamal AL-sahami",
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
