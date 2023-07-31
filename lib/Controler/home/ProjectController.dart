import 'package:library/utls/api/api_response.dart';
import 'package:library/utls/api/constant.dart';
import 'package:library/utls/api/user_service.dart';
import 'package:get/get.dart';

class ProjectController extends GetxController {
  //var _loading;
// @override
//       void onInit() {
//       retrievbook();
//     retrieveEbook();
//     //retrieveEproject();
//          super.onInit();
//      }

  ProjectController() {
    //retrievbook();
    //retrieveEbook();
    retrieveEproject();
    serchProject();
  }
  //List bookList = <dynamic>[].obs;
  List projectList = <dynamic>[];
  List ordrdata = <dynamic>[];
  // List bookList = <dynamic>[];

  int userId = 0;
  int readindex = 0;
  int indexCateg = 0;
  bool loading = false;
  List<dynamic> project = [];
  List<dynamic> serchEbook = [];
  //var names;
  //var hr;

  void loadProject(indexbook) {
    indexCateg = indexbook;
    update();
    //return shawindex;
  }

  void readPBook(indexbook) {
    readindex = indexbook;
    update();
    //return shawindex;
  }

  Future<void> retrieveEproject() async {
    userId = await getUserId();
    ApiResponse response = await showCatogProject();

    if (response.error == null) {
      projectList = response.data as List<dynamic>;
      loading = false;
      update();
    } else if (response.error == unauthorized) {
      logout().then((value) => {});
    }
  }

  Future<void> serchProject() async {
    ApiResponse response = await getAllProject();
    //print(response);

    if (response.error == null) {
      project = response.data as List<dynamic>;
      update();
      //print(response);
    }
    update();
  }
}
