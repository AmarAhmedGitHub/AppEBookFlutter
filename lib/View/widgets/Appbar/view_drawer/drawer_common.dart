import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:library/Controler/theme_controller.dart';
import 'package:library/View/login/login.dart';
import 'package:library/View/setteng/setteng.dart';
import 'package:library/View/widgets/Appbar/view_drawer/about_us.dart';
import 'package:get/get.dart';
// import 'package:share/share.dart';

class DrawerHome extends StatefulWidget {
  DrawerHome({Key? key}) : super(key: key);

  @override
  _DrawerHomeState createState() => _DrawerHomeState();
}

class _DrawerHomeState extends State<DrawerHome> {
  //DrawerController drawercontroler = Get.find();

  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: Drawer(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: const Text(""),
                accountEmail: const Text(""),
                // currentAccountPicture: CircleAvatar(
                //   //backgroundImage: AssetImage("images/books_pile.PNG"),
                // ),
                decoration: BoxDecoration(
                  // color: Get.isDarkMode ? Colors.black : Colors.lightBlue,
                  image: DecorationImage(
                    image: AssetImage("images/books_pile.PNG"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SwitchListTile(
                secondary: const Icon(Icons.ac_unit),
                title: const Text(
                  "Theme",
                ),
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
                activeThumbImage: const AssetImage("images/books_pile.PNG"),
                inactiveThumbImage: const AssetImage("images/books_pile.PNG"),
                activeColor: Colors.blue,
                inactiveTrackColor: Colors.grey,
              ),

              //  ListTile(
              //             leading: Icon(
              //               Icons.screen_lock_landscape_rounded,
              //               //size: _drawerIconSize,
              //               color: Theme.of(context).accentColor,
              //             ),
              //             title: Text(
              //               'Splash Screen',
              //               style:
              //                   TextStyle(fontSize: 17, color: Theme.of(context).accentColor),
              //             ),
              //             onTap: () {
              //               //Get.to(SplashScreen(title: "splashScreen"));
              //               // drawer.navigateToPage(0);
              //               // drawer.nextitem(0);
              //             },
              //           ),

              ListTile(
                leading: Icon(Icons.settings,
                    //size: _drawerIconSize,
                    color: Theme.of(context).accentColor),
                title: Text(
                  '70'.tr,
                  style: TextStyle(
                      //fontSize: _drawerFontSize,
                      color: Theme.of(context).accentColor),
                ),
                onTap: () {
                  Get.to(Setting());
                },
              ),
              Divider(
                color: Theme.of(context).primaryColor,
                height: 1,
              ),
              ListTile(
                leading: Icon(
                  Icons.share,
                  //size: _drawerIconSize,
                  color: Theme.of(context).accentColor,
                ),
                title: Text(
                  '71'.tr,
                  style: TextStyle(
                      //  fontSize: _drawerFontSize,
                      color: Theme.of(context).accentColor),
                ),
                onTap: () {
                  //           Share.share("https://Al_nasser.sas");
                  //Get.to(login());
                },
              ),
              Divider(
                color: Theme.of(context).primaryColor,
                height: 1,
              ),

              ListTile(
                leading: Icon(Icons.person,
                    //size: _drawerIconSize,
                    color: Theme.of(context).accentColor),
                title: Text(
                  '72'.tr,
                  style: TextStyle(
                      //fontSize: _drawerFontSize,
                      color: Theme.of(context).accentColor),
                ),
                onTap: () {
                  Get.to(About_us());
                },
              ),
              Divider(
                color: Theme.of(context).primaryColor,
                height: 1,
              ),
              //   ListTile(
              //   leading: Icon(Icons.rate_review,
              //             //size: _drawerIconSize,
              //              color: Theme.of(context).accentColor),
              //         title: Text(
              //           " STTENG ",
              //           style: TextStyle(
              //          //     fontSize: _drawerFontSize,
              //               color: Theme.of(context).accentColor),
              //         ),
              //         onTap: () {
              //           Get.to(Setting());
              //           // drawer.navigateToPage(1);
              //           // drawer.nextitem(1);
              //         },
              //       ),

              //  Divider(
              //         color: Theme.of(context).primaryColor,
              //         height: 1,
              //       ),

              // ListTile(
              //   leading: Icon(
              //     Icons.comment,
              //     //size: _drawerIconSize,
              //     color: Theme.of(context).accentColor,
              //   ),
              //   title: Text(
              //     '26'.tr,
              //     style: TextStyle(
              //        // fontSize: _drawerFontSize,
              //         color: Theme.of(context).accentColor),
              //   ),
              //   onTap: () {
              //   //  SystemNavigator.pop();
              //   },
              // ),
              //        Divider(
              //   color: Theme.of(context).primaryColor,
              //   height: 1,
              // ),
              ListTile(
                leading: Icon(Icons.logout,
                    //size: _drawerIconSize,
                    color: Theme.of(context).accentColor),
                title: Text(
                  "102".tr,
                  style: TextStyle(
                      //     fontSize: _drawerFontSize,
                      color: Theme.of(context).accentColor),
                ),
                onTap: () {
                  Get.offAll(Loging());
                  // drawer.navigateToPage(1);
                  // drawer.nextitem(1);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget _customDrawer(BuildContext context) {
//   return Padding(
//       padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
//       child: Drawer(
//         child: Column(
//           children: <Widget>[
//             UserAccountsDrawerHeader(
//               accountName: const Text("Indian Innovation"),
//               accountEmail: const Text("indianinnovation@gmail.com"),
//               currentAccountPicture: CircleAvatar(
//                 backgroundImage: AssetImage("images/books_pile.PNG"),
//               ),
//               decoration: BoxDecoration(
//                 color: _isdarkMode ? Colors.black : Colors.lightBlue,
//                 image: DecorationImage(
//                   image: AssetImage("images/books_pile.PNG"),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             SwitchListTile(
//               secondary: const Icon(Icons.ac_unit),
//               title: const Text(
//                 "Theme",
//               ),
//               value: _isdarkMode,
//               onChanged: (value) {
//                 setState(() {
//                   _isdarkMode = value;
//                 });
//                 _isdarkMode
//                     ? Get.changeTheme(ThemeData.dark())
//                     : Get.changeTheme(ThemeData.light());
//                 _themeData.write('darkmode', value);
//               },
//               activeThumbImage: const AssetImage("images/books_pile.PNG"),
//               inactiveThumbImage: const AssetImage("images/books_pile.PNG"),
//               activeColor: Colors.blue,
//               inactiveTrackColor: Colors.grey,
//             ),
//           ],
//         ),
//       ));
// }

//////////////////////////////////////////////////////////////////////////////////////////////////////
///
// CurvedDrawer(
//   //paddingOnly(top: 50)

//   index: drawercontroler.index,
//   width: 100,
//   backgroundColor: Colors.white,
//  //drawercontroler.eftWidth,
//   color:Colors.blue, //drawercontroler.colorPallete[drawercontroler.leftBackgroundColor],
//   buttonBackgroundColor://Colors.blue,
//       Colors.white,//drawercontroler.colorPallete[drawercontroler.leftBackgroundColor],
//   labelColor: Colors.black,//drawercontroler.colorPallete[drawercontroler.leftTextColor],
//   items: drawercontroler.drawerItems,
//   onTap: (newIndex) {

//     //Colors.blue;
//     drawercontroler.nextitem(newIndex);
//     drawercontroler.navigateToPage(newIndex);
//   },
// );
