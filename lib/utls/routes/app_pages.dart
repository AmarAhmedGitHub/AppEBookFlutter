import 'package:library/View/login/login.dart';
import 'package:library/loading.dart';
import 'package:get/get.dart';

import 'binding/dashboard_binding.dart';

class AppPages {
  static var list = [
    GetPage(
      name: "/",
      page: () => Loading(),
      binding: DashboardBinding(),
    ),

    //     GetPage(
    //   //name: Paths.home,
    //  // page: () => Home(
    //     //title: 'home',
    //   //),
    //   binding: DashboardBinding(),
    // ),
    // GetPage(
    //   name: Paths.share,
    //   page: () => share(),
    // ),
    // GetPage(
    //   name: Paths.work,
    //   page: () => work(),
    // ),
    // GetPage(
    //   name: Paths.abutUs,
    //   page: () => abutUs(),
    // ),
    // GetPage(
    //   name: Paths.book,
    //   page: () => Book(),
    // ),
    // GetPage(
    //   name: Paths.phone,
    //   page: () => phone(),
    // ),
  ];
}
