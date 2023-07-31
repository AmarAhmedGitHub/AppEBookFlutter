import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  var tabIndex = 0;

  final items = <Widget>[
    Icon(
      Icons.home,
      size: 30,
    ),
    Icon(
      Icons.local_library_rounded,
      size: 30,
      semanticLabel: "texr",
    ),
    Icon(
      Icons.sd,
      size: 30,
    ),
    
    Icon(
      
      Icons.favorite,
      
      size: 30,
    ),
    Icon(
      Icons.settings,
      size: 30,
      //label: 'Alerts',
    ),
  ];

  void changeTabIndex(int index,) {
    tabIndex = index;
    update();
  }
}
