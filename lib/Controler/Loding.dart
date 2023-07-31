import 'package:library/View/Home/home_page.dart';
import 'package:library/View/login/login.dart';
import 'package:library/utls/api/api_response.dart';
import 'package:library/utls/api/constant.dart';
import 'package:library/utls/api/user_service.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class LodingController extends GetxController {
  var massge;
  LodingController() {
    loadUserInfo();
  }
  int loaderSelect = 0;
  void loadUserInfo() async {
    String token = await getToken();
    if (token == '') {
      // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>Login()), (route) => false);
      loaderSelect = 1;
      Get.to(Loging());
    } else {
      ApiResponse response = await getUserDetail();
      if (response.error == null) {
        Get.offAll(HomeView());
        loaderSelect = 2;
        // Navigator.of(context).pushAndRemoveUntil(
        //     MaterialPageRoute(builder: (context) => Home()), (route) => false);
      } else if (response.error == unauthorized) {
        Get.offAll(Loging());
        loaderSelect = 3;
// Navigator.of(context).pushAndRemoveUntil(
        //     MaterialPageRoute(builder: (context) => Login()), (route) => false);
      } else {
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //   content: Text('${response.error}'),
        // ));
        massge = response.error;
      }
    }
  }
}
