import 'package:get/get.dart';
import 'package:library/utls/api/api_response.dart';
import 'package:library/utls/api/user_service.dart';

class NotificationsController extends GetxController{
NotificationsController(){
    retrieveNotifications();

}

  List<dynamic> notifications = [];

  Future<void> retrieveNotifications() async {
    ApiResponse response = await getNotifications();

    if (response.error == null) {
//      setState(() {
      notifications = response.data as List<dynamic>;
      //    });
      print(response);
    }
  }

    Future makeAsRead() async {
    ApiResponse response = await makeAsReadNotifications();

    if (response.error == null) {
      // setState(() {

      // });
      //  print(response);
    }
  }

}