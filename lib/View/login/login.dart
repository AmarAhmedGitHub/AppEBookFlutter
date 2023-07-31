import 'package:flutter/material.dart';
import 'package:library/View/dashboard/dashboard_page.dart';
import 'package:library/Model/user.dart';
import 'package:library/View/widgets/themes/theme_helper.dart';
import 'package:library/utls/api/api_response.dart';
import 'package:library/utls/api/user_service.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class Loging extends StatefulWidget {
  const Loging({Key? key}) : super(key: key);

  @override
  _LodingState createState() => _LodingState();
}

class _LodingState extends State<Loging> {
  late ApiResponse response;
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  bool loading = false;
  // double _headerHeight = 250;
  void _loginUser() async {
    response = await login(txtEmail.text, txtPassword.text);
    if (response.error == null) {
      _saveAndRedirectToHome(response.data as User);
    } else {
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

  void _saveAndRedirectToHome(User user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('token', user.token ?? '');
    await pref.setInt('userId', user.id ?? 0);
    await pref.setString('username', user.username ?? '');
    await pref.setString('image', user.avatar ?? '');
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => DashboardPage()),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 80,
            ),
            Container(
              height: 120,
              width: 100,
              //height: _headerHeight,
              // child: HeaderWidget(_headerHeight, true,
              //     Icons.login_rounded), //let's create a common header widget
              child: Image.asset("images/logo.PNG"),
            ),
            SafeArea(
              child: Container(
                  //  height: MediaQuery.of(context).size.height,
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  margin: EdgeInsets.fromLTRB(
                      20, 10, 20, 10), // This will be the login form
                  child: Column(
                    children: [
                      Text(
                        "10".tr,
                        style: TextStyle(
                            fontSize: 60, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '11'.tr,
                        //   style: TextStyle(color: Colors.black),
                      ),
                      SizedBox(height: 30.0),
                      Form(
                          key: formkey,
                          child: Column(
                            children: [
                              Container(
                                child: TextFormField(
                                  style: TextStyle(color: Colors.black),
                                  keyboardType: TextInputType.emailAddress,
                                  controller: txtEmail,
                                  validator: (val) =>
                                      val!.isEmpty ? '12'.tr : null,
                                  decoration: ThemeHelper()
                                      .textInputDecoration('13'.tr, '17'.tr),
                                ),
                                decoration:
                                    ThemeHelper().inputBoxDecorationShaddow(),
                              ),
                              SizedBox(height: 30.0),
                              Container(
                                child: TextFormField(
                                  controller: txtPassword,
//               obscureText: true,
                                  style: TextStyle(color: Colors.black),

                                  validator: (val) =>
                                      val!.length < 6 ? '14'.tr : null,

                                  obscureText: true,
                                  decoration: ThemeHelper()
                                      .textInputDecoration('15'.tr, '18'.tr),
                                ),
                                decoration:
                                    ThemeHelper().inputBoxDecorationShaddow(),
                              ),
                              SizedBox(height: 15.0),

                              // SizedBox(height: 10,),
                              loading
                                  ? Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : Container(
                                      decoration: ThemeHelper()
                                          .buttonBoxDecoration(context),
                                      child: ElevatedButton(
                                        style: ThemeHelper().buttonStyle(),
                                        child: Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              40, 10, 40, 10),
                                          child: Text(
                                            '16'.tr.toUpperCase(),
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ),
                                        onPressed: () {
                                          if (formkey.currentState!
                                              .validate()) {
                                            setState(() {
                                              loading = true;
                                              _loginUser();
                                            });
                                          }
                                        },
                                      ),
                                    ),
                            ],
                          )),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
