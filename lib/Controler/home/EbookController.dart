import 'package:library/utls/api/api_response.dart';
import 'package:library/utls/api/constant.dart';
import 'package:library/utls/api/user_service.dart';
import 'package:get/get.dart';

class EbookController extends GetxController {
  EbookController() {
    retrieveEbook();
    serchEBook();
  }
  List ebookList = <dynamic>[].obs;
  List<dynamic> book = [];
  List<dynamic> serchbook = [];

  int userId = 0;
  int readindex = 0;
  int indexCateg = 0;
  bool loading = false;
  int selected = 0;
  var names;
  List<dynamic> Ebook = [];
  List<dynamic> serchEbook = [];

  void loadEBook(indexbook) {
    indexCateg = indexbook;
    update();
    //return shawindex;
  }

  void readBook(indexbook) {
    readindex = indexbook;
    update();
    //return shawindex;
  }

  Future<void> retrieveEbook() async {
    userId = await getUserId();
    ApiResponse response = await showCatogEbook();

    if (response.error == null) {
      ebookList = response.data as List<dynamic>;
      loading = false;
      update();
    } else if (response.error == unauthorized) {
      logout().then((value) => {});
      update();
    }
  }

  Future<void> serchEBook() async {
    ApiResponse response = await getAllEBook();
    //print(response);

    if (response.error == null) {
      Ebook = response.data as List<dynamic>;
      update();
      //print(response);
    }
    update();
  }
}
