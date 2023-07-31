import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library/utls/api/Order.dart';
import 'package:library/utls/api/api_response.dart';
import 'package:library/utls/api/constant.dart';
import 'package:library/utls/api/user_service.dart';

class BookController extends GetxController {
  BookController() {
    retrievbook();
    retrieveOrder();
    serchBook();
  }

  List bookList = <dynamic>[].obs;
  List bowrronList = <dynamic>[];
  int userId = 0;
  int readindex = 0;
  int indexCateg = 0;
  bool loading = false;
  bool borrw = false;
  //var names;
  //var hr;
  int i = 5;
  List<dynamic> postList = [];
  List<dynamic> book = [];
  List<dynamic> serchbook = [];
  List<dynamic> order = [];


void loadBook(indexbook) {
    indexCateg = indexbook;
    update();
    //return shawindex;
  }

  void readBook(indexbook) {
    readindex = indexbook;
    update();
    //return shawindex;
  }


  Future<void> retrievbook() async {
    userId = await getUserId();
    ApiResponse response = await showCatog();

    if (response.error == null) {
      bookList = response.data as List<dynamic>;
      loading = true;
      update();
    } else if (response.error == unauthorized) {
      logout().then((value) => {});
    }
  }

  Future<void> borrwn(doc0, docu1, docu2, docu3) async {
    ApiResponse response = await requestBorrwn(doc0, docu1, docu2, docu3);
    if (response.error == null) {
      borrw = false;
      SnackBar(content: Text('${response.error}'));
      update();
    } else {
      SnackBar(content: Text('${response.error}'));
      borrw = true;
      update();
    }
  }

  Future<void> serchBook() async {
    ApiResponse response = await getAllBook();
    //print(response);

    if (response.error == null) {
      book = response.data as List<dynamic>;
      update();
      //print(response);
    }
    update();
  }

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
