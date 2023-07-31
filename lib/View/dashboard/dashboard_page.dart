import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:library/Controler/dashboard/dashboard_controller.dart';
import 'package:library/View/FavoriteList/FavoriteView.dart';
import 'package:library/View/Home/home_page.dart';
import 'package:library/View/Order/Order.dart';
import 'package:library/View/Sections/Sections.dart';
import 'package:library/View/setteng/setteng.dart';
import 'package:library/View/widgets/Appbar/view_drawer/drawer_common.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

final themedata = GetStorage();

// ignore: must_be_immutable
class DashboardPage extends GetView<DashboardController> {
//   final bool _darkMode = _themedata.read('darkmode') ?? false;

//  final _themeData = GetStorage();
//   bool _isdarkMode = false;
//   @override
//   void initState() {
//     //super.initState();
//     _themeData.writeIfNull("darkmode", false);
//     _isdarkMode = _themeData.read("darkmode");
//   }
  ///  final items=<Widget>[].obs;
  String selectedLang = "en";
  @override
  Widget build(BuildContext context) {
    //int index = 2;

    return GetBuilder<DashboardController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: Color(0xFFC7ECF4),
          drawer: DrawerHome(),
          body: SafeArea(
            child: IndexedStack(
              index: controller.tabIndex,
              children: [
                HomeView(),
                Section(),
                OrderPage(),
                FavoriteModle(),
                Setting(),
              ],
            ),
          ),
          bottomNavigationBar: CurvedNavigationBar(
            height: 60,
            //index:index,
            items: controller.items,
            backgroundColor: Get.isDarkMode ? Color(0xFF000000) : Colors.white,
            //Theme.of(context).backgroundColor ,//_selectedLang=='ar'? Colors.white:Colors.black,

            onTap: controller.changeTabIndex,
            //color:
            color: Get.isDarkMode ? Colors.black : Colors.blue,
            //:  Color(0xFF5A8DEE),//Colors.blue.shade300, //Colors.blue.shade300,

            index: controller.tabIndex,
          ),
        );
      },
    );
  }

  CurvedNavigationBarItem({required IconData icon, required String label}) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: label,
    );
  }
}
