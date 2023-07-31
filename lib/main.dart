import 'package:flutter/material.dart';
import 'package:library/View/local/local.dart';
import 'package:library/View/local/local_controller.dart';
import 'package:library/Controler/theme_controller.dart';
import 'package:library/utls/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'View/widgets/themes/app_theme.dart';

final themedata = GetStorage();
String language = "";
late SharedPreferences sharepref;
void main() async {
  await GetStorage.init();
  sharepref = await SharedPreferences.getInstance();
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.getInstance().then((instance) {
    language = instance.getString('language')!;
  });
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  //final bool _darkMode = _themedata.read('darkmode') ?? false;
  MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeController _themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    MyLocalController controller = Get.put(MyLocalController());

    return GetMaterialApp(
      themeMode: _themeController.theme,
      theme: Themes.lightTheme,
      darkTheme: Themes.darkTheme,
      locale: controller.intialLang,
      initialRoute: "/",
      getPages: AppPages.list,

      //fallbackLocale: Locale('en'),
      translations: MyLocale(),
      debugShowCheckedModeBanner: false,

      //theme: _darkMode ? ThemeData.dark() : ThemeData.light(),
      // theme: AppTheme.light,
      // darkTheme: AppTheme.dark,
      // themeMode: ThemeMode.system,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // final _themeData = GetStorage();
  // bool _isdarkMode = false;
  // @override
  // void initState() {
  //   super.initState();
  //   _themeData.writeIfNull("darkmode", false);
  //   _isdarkMode = _themeData.read("darkmode");
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
//      drawer: _customDrawer(context),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
          ],
        ),
      ),
    );
  }

  // Widget _customDrawer(BuildContext context) {
  //   return Padding(
  //       padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
  //       child: Drawer(
  //         child: Column(
  //           children: <Widget>[
  //             UserAccountsDrawerHeader(
  //               accountName: const Text("Indian Innovation"),
  //               accountEmail: const Text("indianinnovation@gmail.com"),
  //               currentAccountPicture: CircleAvatar(
  //                 backgroundImage: AssetImage("images/books_pile.PNG"),
  //               ),
  //               decoration: BoxDecoration(
  //                 color: _isdarkMode ? Colors.black : Colors.lightBlue,
  //                 image: DecorationImage(
  //                   image: AssetImage("images/books_pile.PNG"),
  //                   fit: BoxFit.cover,
  //                 ),
  //               ),
  //             ),
  //             SwitchListTile(
  //               secondary: const Icon(Icons.ac_unit),
  //               title: const Text(
  //                 "Theme",
  //               ),
  //               value: _isdarkMode,
  //               onChanged: (value) {
  //                 setState(() {
  //                   _isdarkMode = value;
  //                 });
  //                 _isdarkMode
  //                     ? Get.changeTheme(ThemeData.dark())
  //                     : Get.changeTheme(ThemeData.light());
  //                 _themeData.write('darkmode', value);
  //               },
  //               activeThumbImage: const AssetImage("images/books_pile.PNG"),
  //               inactiveThumbImage: const AssetImage("images/books_pile.PNG"),
  //               activeColor: Colors.blue,
  //               inactiveTrackColor: Colors.grey,
  //             ),
  //           ],
  //         ),
  //       ));
  // }

}
