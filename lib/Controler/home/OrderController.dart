import 'package:get/get.dart';
import 'package:library/utls/api/api_response.dart';
import 'package:library/utls/api/user_service.dart';

class OrderController extends GetxController{
OrderController(){
retrieveOrder();

}
List<dynamic> order = [];

  Future<void> retrieveOrder() async {
    ApiResponse response = await getOrders();
    //print(response);

    if (response.error == null) {
      order = response.data as List<dynamic>;
      update();
      // print(response);
    }
    update();
  }

}