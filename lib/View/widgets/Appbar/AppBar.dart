import 'package:flutter/material.dart';
import 'package:library/Controler/home/homecontroller.dart';
import 'package:library/View/DetailsView/Bookpage/Serch.dart';
import 'package:get/get.dart';

class RoundAppBar extends StatelessWidget with PreferredSizeWidget {
  final double barHeight = 10;
  final String title;
  final List namePage;
  final BuildContext ContextActio;
  HomeController homeController = Get.put(HomeController());
  RoundAppBar(
      {required this.title,
      required this.namePage,
      required this.ContextActio});
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + barHeight);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xFF5A8DEE),
      title: Center(child: Text(title)),
      actions: [
        //IconButton(onPressed: () {}, icon: Icon(Icons.search)),
        //  IconButton(onPressed: () {}, icon: Icon(Icons.search)),
        IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                  context: ContextActio, delegate: DataSearch(list: namePage));
            }) // IconButton(onPressed: () {}, icon: Icon(Icons.shopping_cart_outlined)),
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(10.0),
        ),
      ),
//      actions: [Icon(Icons.dehaze)],
    );
  }
}
