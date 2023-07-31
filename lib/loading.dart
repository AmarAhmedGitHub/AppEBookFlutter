import 'package:flutter/material.dart';
import 'package:library/Controler/dashboard/dashboard_controller.dart';
import 'package:library/utls/api/api_response.dart';
import 'package:library/utls/api/constant.dart';
import 'package:library/utls/api/user_service.dart';
import 'package:get/get.dart';

import 'View/dashboard/dashboard_page.dart';
import 'View/login/login.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

DashboardController dashboardController = Get.put(DashboardController());

class _LoadingState extends State<Loading> {
  late String massge;

  void loadUserInfo() async {
    String token = await getToken();
    if (token == '') {
      // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>Login()), (route) => false);
      // loaderSelect = 1;
      Get.to(Loging());
    } else {
      ApiResponse response = await getUserDetail();
      if (response.error == null) {
        Get.offAll(DashboardPage());
        // dashboardController.changeTabIndex(0);
        //Get.to(HomeView());
        //  loaderSelect = 2;
        // Navigator.of(context).pushAndRemoveUntil(
        //     MaterialPageRoute(builder: (context) => Home()), (route) => false);
      } else if (response.error == unauthorized) {
        Get.offAll(Loging());
        //loaderSelect = 3;
// Navigator.of(context).pushAndRemoveUntil(
        //     MaterialPageRoute(builder: (context) => Login()), (route) => false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('${response.error}'),
        ));
        // response.error;
      }
    }
  }

  @override
  void initState() {
    loadUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Column(
          children: [
            SizedBox(
              height: 80,
            ),
            Container(
              height: 180,
              width: 160,
              //height: _headerHeight,
              // child: HeaderWidget(_headerHeight, true,
              //     Icons.login_rounded), //let's create a common header widget
              child: Image.asset("images/logo.PNG"),
            ),
            SizedBox(
              height: 160,
            ),
            Container(
//            height: MediaQuery.of(context).size.height,
                color: Colors.white,
                child: Center(child: CircularProgressIndicator())),
          ],
        )));
  }
}
