//import 'package:library/Controler/theme_controller.dart';
//import 'package:library/View/themes/theme_controller.dart';
import 'package:library/Controler/theme_controller.dart';
import 'package:library/View/login/login.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';

import 'edit_profile.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  final themeController = Get.find<ThemeController>();
  String _selectedLang = "en";
  @override
  Widget build(BuildContext context) {
    //MyLocalController controllerLan = Get.find();
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            height: 10,
          ),
          Center(
            child: Text(
              "90".tr,
              style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontSize: 25,
                  fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Center(
            child: Stack(
              children: [
                Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                      border: Border.all(
                        width: 4,
                        //color: Theme.of(context).scaffoldBackgroundColor
                      ),
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
                          image: NetworkImage(
                            "images/profile.JPG",
                          ))),
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
                        color: Colors.black,
                      ),
                      child: Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                    )),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Center(
            child: Column(
              children: [
                Text(
                  "91".tr,
                  style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  '92'.tr,
                  style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Divider(
            color: Theme.of(context).primaryColor,
            height: 3,
          ),

          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DropdownButton(
                icon: Icon(Icons.language),
                underline: SizedBox(),
                items: [
                  DropdownMenuItem(
                    child: Text("en"),
                    value: 'en',
                  ),
                  DropdownMenuItem(
                    child: Text("ar"),
                    value: 'ar',
                  ),
                ],
                value: _selectedLang,
                onChanged: (value) {
                  setState(() {
                    _selectedLang = value.toString();
                  });
                  Get.updateLocale(Locale(_selectedLang));
                },
              ),
              Switch(
                value: Get.isDarkMode,
                onChanged: (value) {
                  if (Get.isDarkMode) {
                    themeController.changeThemeMode(ThemeMode.light);
                    themeController.saveTheme(false);
                  } else {
                    themeController.changeThemeMode(ThemeMode.dark);
                    themeController.saveTheme(true);
                  }
                },
              )
            ],
          ),

          Divider(
            color: Theme.of(context).primaryColor,
            height: 3,
          ),
          SizedBox(
            height: 30,
          ),
          ListTile(
            leading: Icon(Icons.edit,
                //size: _drawerIconSize,
                color: Theme.of(context).accentColor),
            title: Text(
              '100'.tr,
              style: TextStyle(
                  //     fontSize: _drawerFontSize,
                  color: Theme.of(context).accentColor),
            ),
            onTap: () {
              Get.to(EditProfilePage());
              // drawer.navigateToPage(1);
              // drawer.nextitem(1);
            },
          ),
          Divider(
            color: Theme.of(context).primaryColor,
            height: 1,
          ),

          ListTile(
            leading: Icon(Icons.logout,
                //size: _drawerIconSize,
                color: Theme.of(context).accentColor),
            title: Text(
              '102'.tr,
              style: TextStyle(
                  //     fontSize: _drawerFontSize,
                  color: Theme.of(context).accentColor),
            ),
            onTap: () {
              Get.offAll(Loging());
            },
          ),
          Divider(
            color: Theme.of(context).primaryColor,
            height: 1,
          ),
          //buildTextField("Full Name", "Dor Alex", false),
          // buildTextField("E-mail", "alexd@gmail.com", false),
          // buildTextField("Password", "********", true),
          // buildTextField("Location", "TLV, Israel", false),
          // SizedBox(
          //   height: 35,
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     OutlineButton(
          //       padding: EdgeInsets.symmetric(horizontal: 50),
          //       shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(20)),
          //       onPressed: () {},
          //       child: Text("CANCEL",
          //           style: TextStyle(
          //               fontSize: 14,
          //               letterSpacing: 2.2,
          //               color: Colors.black)),
          //     ),
          //     RaisedButton(
          //       onPressed: () {},
          //       color: Colors.green,
          //       padding: EdgeInsets.symmetric(horizontal: 50),
          //       elevation: 2,
          //       shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(20)),
          //       child: Text(
          //         "SAVE",
          //         style: TextStyle(
          //             fontSize: 14,
          //             letterSpacing: 2.2,
          //             color: Colors.white),
          //       ),
          //     )
          //   ],
          // )
        ],
      ),
    );
  }
}
