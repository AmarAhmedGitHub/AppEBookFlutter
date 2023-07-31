import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
//  LoginController() {}

  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();

  bool loading = false;
  //double _headerHeight = 250;
  // void _loginUser() async {
  //   ApiResponse response = await login(txtEmail.text, txtPassword.text);
  //   if (response.error == null) {
  //     _saveAndRedirectToHome(response.data as User);
  //   } else {
  //     // setState(() {
  //     loading = false;
  //     // });
  //     update();
  //     }
  //    // ScaffoldMessenger.of(context)
  //       //  Get.snackbar("content": Text('${response.error}')));
  //   }
  // }

  // void _saveAndRedirectToHome(User user) async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   await pref.setString('token', user.token ?? '');
  //   await pref.setInt('userId', user.id ?? 0);
  //   //Navigator.of(context).pushAndRemoveUntil(
  //       MaterialPageRoute(builder: (context) => DashboardPage());
  //     //  (route) => false);
  // }

}
