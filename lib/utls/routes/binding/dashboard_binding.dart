import 'package:library/Controler/FavoriteListController/FavController.dart';
import 'package:library/Controler/LoginController/LoginController.dart';
import 'package:library/Controler/dashboard/dashboard_controller.dart';
import 'package:library/Controler/home/EbookController.dart';
import 'package:library/Controler/home/ProjectController.dart';
import 'package:library/Controler/home/homecontroller.dart';
import 'package:library/View/local/local_controller.dart';
import 'package:library/Controler/theme_controller.dart';
import 'package:get/get.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(() => DashboardController());
    //Get.lazyPut<LoginController>(() => LoginController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<EbookController>(() => EbookController());
    Get.lazyPut<ProjectController>(() => ProjectController());
    Get.lazyPut<FavController>(() => FavController());
    Get.lazyPut<MyLocalController>(() => MyLocalController());
    Get.lazyPut<ThemeController>(() => ThemeController());
    //Get.lazyPut<Drawercontroller>(() => Drawercontroller());
  }
}
