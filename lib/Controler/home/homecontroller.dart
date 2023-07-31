import 'package:flutter/material.dart';
import 'package:library/utls/api/Order.dart';
import 'package:library/utls/api/api_response.dart';
import 'package:library/utls/api/constant.dart';
import 'package:library/utls/api/user_service.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  HomeController() {
   // retrievbook();
    //retrieveEbook();
    //retrieveEproject();
    //serchBook();
    //borrwn();
    
  }

  int counter = 0;

  List bookList = <dynamic>[].obs;
  List bowrronList = <dynamic>[];
  int selected = 0;
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

  // Future<void> retrievbook() async {
  //   userId = await getUserId();
  //   ApiResponse response = await showCatog();

  //   if (response.error == null) {
  //     bookList = response.data as List<dynamic>;
  //     loading = true;
  //     update();
  //   } else if (response.error == unauthorized) {
  //     logout().then((value) => {});
  //   }
  // }

  // Future<void> borrwn(doc0, docu1, docu2, docu3) async {
  //   ApiResponse response = await requestBorrwn(doc0, docu1, docu2, docu3);
  //   if (response.error == null) {
  //     borrw = false;
  //     SnackBar(content: Text('${response.error}'));
  //     update();
  //   } else {
  //     SnackBar(content: Text('${response.error}'));
  //     borrw = true;
  //     update();
  //   }
  // }

  // Future<void> serchBook() async {
  //   ApiResponse response = await getAllBook();
  //   //print(response);

  //   if (response.error == null) {
  //      book = response.data as List<dynamic>;
  //     update();
  //     //print(response);
  //   }
  //   update();
  // }


  Future makeAsRead() async {
    ApiResponse response = await makeAsReadNotifications();

    if (response.error == null) {
      // setState(() {

      // });
      //  print(response);
    }
  }
}


// Future downloa2(String url, String savePath) async {
//   //await dio.post('/test', data: {'id': 12, 'name': 'wendu'});
//   Dio dio = Dio();
//   try {
//     String token = await getToken();
//     var response = await dio.download(
//       url,
//       //downlodUR,L
//       savePath,
//       //data: {'path': url},
//       //onReceiveProgress: showDownloadProgress,
//       //onSendProgress:showDownloadProgress ,
//       //Received data with List<int>
//       options: Options(
//           headers: {
//             'Accept': 'application/json',
//             'Authorization': 'Bearer $token'
//           },
//           method: 'POST',
//           responseType: ResponseType.bytes,
//           followRedirects: false,
//           validateStatus: (status) {
//             return status! < 500;
//           }),
//     );
//     // print(response);
//     //print(response.headers);
//     File file = File(savePath);
//     await file.create();
//     var raf = file.openSync(mode: FileMode.write);
//     // response.data is Lis//t<int> type
//     raf.writeFromSync(response.data);
//     await raf.close();
//   } catch (e) {
//     print(e);
//   }
// }

// void showDownloadProgress(received, total) {
//   if (total != -1) {
//     print((received / total * 100).toStringAsFixed(0) + "%");
//   }
// }
