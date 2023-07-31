import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../main.dart';

class MyLocalController extends GetxController {
  Locale intialLang = sharepref.getString("language") == null
      ? Get.deviceLocale!
      : Locale(sharepref.getString("language")!);

  void changelang(String codelaneg) async {
    Locale locale = Locale(codelaneg);
    sharepref.setString("language", codelaneg);

    Get.updateLocale(locale);
  }
}
