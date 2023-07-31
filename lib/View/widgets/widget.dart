// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:library/Controler/FavoriteListController/FavController.dart';
// import 'package:library/utls/api/Order.dart';
// import 'package:get/get.dart';

// FavController favController = Get.put(FavController());

// Widget favIcon(datafavId,  nameSection,check) {
//   return IconButton(
//     onPressed: () {
//       favController.check(datafavId, check);
//       if (favController.selected != true) {
//         print("Exist");
//         favController.deletePerson(datafavId, check);
//       } else {
//         print("Notfound");
//         favController.insertBook(nameSection);
//       }
//     },
//     icon: favController.selected == true
//         ? //selectfav()
//         //?
//         Icon(
//             Icons.favorite,
//             color: Colors.red,
//             size: 35,
//           )
//         : Icon(
//             Icons.favorite_border,
//             size: 35,
//           ),
//   );
// }

// Widget addBorrwn(nameorder, idorder, namesection) {
//   return IconButton(
//       onPressed: () {
//         requestBorrwn('${nameorder}', '${idorder}', '${namesection}', '1');
//       },
//       icon: Icon(Icons.ac_unit_sharp));
// }
