import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library/utls/api/constant.dart';
import 'package:library/utls/api/user_service.dart';
import 'package:http/http.dart' as http;

import 'api_response.dart';

class Order {}

Future<ApiResponse> requestBorrwn(
    String docuId, String docuName, String docuCat, String typeOrder) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.post(Uri.parse(orderURL), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    }, body: {
      'id_docus': docuId,
      'name_docus': docuName,
      'category_docus': docuCat,
      'type_order': typeOrder
    });

    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['message'];
        //.map((p) => BookCategory.fromJson(p))
        //.toList();
        // we get list of posts, so we need to map each item to post model
        // apiResponse.data;
        Get.snackbar('lllll', 'kkkk', titleText: Text('${apiResponse.data}'));
        print(response.body);

        break;
      case 401:
        apiResponse.error = unauthorized;
        Get.snackbar('hhh', 'jjj', titleText: Text('${apiResponse.error}'));

        //print("xxxxx");
        break;
      default:
        // apiResponse.error = somethingWentWrong;
        print(response.body);
        // Get.snackbar('hhh', 'jjj', titleText: Text('${response.body}'));
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
    print(e);
  }
  //print('$apiResponse');
  return apiResponse;
}
