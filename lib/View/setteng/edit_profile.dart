import 'dart:io';

import 'package:flutter/material.dart';
import 'package:library/Model/user.dart';
import 'package:library/View/login/login.dart';
import 'package:library/utls/api/api_response.dart';
import 'package:library/utls/api/constant.dart';
import 'package:library/utls/api/user_service.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  File? file;
  User? user;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController txtUserNameController = TextEditingController();
  TextEditingController txtoldpassController = TextEditingController();
  TextEditingController txtpassController = TextEditingController();
  TextEditingController txtpassConnController = TextEditingController();

  void getUser() async {
    ApiResponse response = await getUserDetail();
    if (response.error == null) {
      setState(() {
        user = response.data as User;
        txtUserNameController.text = user!.username ?? '';
        print(user!.avatar);
      });
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => Loging()),
                (route) => false)
          });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

  Future getImage() async {
    final myfile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (myfile != null) {
      setState(() {
        file = new File(myfile.path);
      });
    }
  }

  bool showPassword = false;
  bool showoldPassword = false;

  void updateProfile() async {
    ApiResponse response = await updateUser(
        txtUserNameController.text,
        txtoldpassController.text,
        txtpassController.text,
        txtpassConnController.text,
        getStringImage(file));

    if (response.error == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.data}')));
    } else if (response.error == 'unauthorized') {
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

  @override
  void initState() {
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,

            //  fontSize: _drawerFontSize,
            color: Theme.of(context).accentColor,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Center(
                child: Text(
                  "Edit Profile",
                  style: TextStyle(
                      //  fontSize: _drawerFontSize,
                      color: Theme.of(context).accentColor),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                child: Stack(
                  children: [
                    user != null
                        ? Container(
                            width: 130,
                            height: 130,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 4,
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor),
                              boxShadow: [
                                BoxShadow(
                                    spreadRadius: 2,
                                    blurRadius: 10,
                                    color: Colors.black.withOpacity(0.1),
                                    offset: Offset(0, 10))
                              ],
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: file == null
                                      ? user!.avatar != null
                                          ? NetworkImage(urlFileHelp +
                                              'studentProfiles/1656269459.png')
                                          : AssetImage('images/books_pile.PNG')
                                              as ImageProvider
                                      : FileImage(file!)),
                            ),
                          )
                        : CircularProgressIndicator(
                            color: Colors.black,
                          ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),

                            //  fontSize: _drawerFontSize,
                            color: Theme.of(context).accentColor,
                          ),
                          child: InkWell(
                            child: Icon(Icons.edit,

                                //  fontSize: _drawerFontSize,
                                color: Theme.of(context).accentColor),
                            onTap: () => getImage(),
                          ),
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 35,
              ),
              Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: txtUserNameController,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person_outline),
                          contentPadding: EdgeInsets.all(15),
                          labelText: "User Name",
                          labelStyle: TextStyle(

                              //  fontSize: _drawerFontSize,
                              color: Theme.of(context).accentColor,
                              fontFamily: "normal"),
                          filled: true,
                          //    fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.blueGrey,
                                  style: BorderStyle.solid,
                                  width: 1)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.blue,
                                  style: BorderStyle.solid,
                                  width: 1))),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: txtoldpassController,
                      textInputAction: TextInputAction.next,
                      obscureText: showoldPassword,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock_outline,
                              //  fontSize: _drawerFontSize
                              color: Theme.of(context).accentColor),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                showoldPassword = !showoldPassword;
                              });
                            },
                            icon: Icon(Icons.remove_red_eye,

                                //  fontSize: _drawerFontSize,
                                color: Theme.of(context).accentColor),
                          ),
                          contentPadding: EdgeInsets.all(15),
                          labelText: "Old Password",
                          labelStyle: TextStyle(fontFamily: "normal"),
                          filled: true,
                          //fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.blueGrey,
                                  style: BorderStyle.solid,
                                  width: 1)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.blue,
                                  style: BorderStyle.solid,
                                  width: 1))),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: txtpassController,
                      textInputAction: TextInputAction.next,
                      obscureText: showPassword,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock_outline,
                              //  fontSize: _drawerFontSize,
                              color: Theme.of(context).accentColor),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                showPassword = !showPassword;
                              });
                            },
                            icon: Icon(
                              Icons.remove_red_eye,

                              //  fontSize: _drawerFontSize,
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                          contentPadding: EdgeInsets.all(15),
                          labelText: "New Password",
                          labelStyle: TextStyle(fontFamily: "normal"),
                          filled: true,
                          //fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.blueGrey,
                                  style: BorderStyle.solid,
                                  width: 1)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.blue,
                                  style: BorderStyle.solid,
                                  width: 1))),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: txtpassConnController,
                      validator: (value) {
                        if (value != txtpassController.text) {
                          return "not math";
                        }
                      },
                      textInputAction: TextInputAction.done,
                      obscureText: true,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock_outline),
                          contentPadding: EdgeInsets.all(15),
                          labelText: "Confirm New Password",
                          labelStyle: TextStyle(

                              //  fontSize: _drawerFontSize,
                              //  color: Theme.of(context).accentColor,
                              fontFamily: "normal"),
                          filled: true,
                          //fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.blueGrey,
                                  style: BorderStyle.solid,
                                  width: 1)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  //     color: Colors.blue,
                                  //      style: BorderStyle.solid,
                                  width: 1))),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // ignore: deprecated_member_use
                  // OutlineButton(
                  //   padding: EdgeInsets.symmetric(horizontal: 50),
                  //   shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(20)),
                  //   onPressed: () {
                  //     Get.back();
                  //   },
                  //   child: Text("CANCEL",
                  //       style: TextStyle(
                  //         fontSize: 14,
                  //         letterSpacing: 2.2,
                  //         //color: Colors.black
                  //       )),
                  // ),
                  // ignore: deprecated_member_use
                  // RaisedButton(
                  //   onPressed: () {
                  //     updateProfile();
                  //   },
                  //   color: Colors.green,
                  //   padding: EdgeInsets.symmetric(horizontal: 50),
                  //   elevation: 2,
                  //   shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(20)),
                  //   child: Text(
                  //     "SAVE",
                  //     style: TextStyle(
                  //         fontSize: 14,
                  //         letterSpacing: 2.2,
                  //
                  //         //  fontSize: _drawerFontSize,
                  //         color: Theme.of(context).accentColor),
                  //   ),
                  // )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
