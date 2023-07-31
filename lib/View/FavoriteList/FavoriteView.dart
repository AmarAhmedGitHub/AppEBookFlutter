import 'package:flutter/material.dart';
import 'package:library/Controler/FavoriteListController/FavController.dart';
import 'package:library/View/widgets/Appbar/AppBar.dart';
import 'package:library/View/widgets/Appbar/view_drawer/drawer_common.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class FavoriteModle extends StatefulWidget {
  //GetView<FavController> {
  FavoriteModle({
    Key? key,
  }) : super(key: key);

  @override
  _FavoriteModleState createState() => _FavoriteModleState();
}

class _FavoriteModleState extends State<FavoriteModle> {
//  FavController favController = Get.put(FavController());
  int idDelet = 0;
  @override
  Widget build(BuildContext context) {
    //bool loading = false;
    FavController favController = Get.put(FavController());

    return Scaffold(
        drawer: DrawerHome(),
        appBar: AppBar(
          backgroundColor: Color(0xFF5A8DEE),
          title: Center(child: Text('Library Favoriete ')),
          actions: [
            //IconButton(onPressed: () {}, icon: Icon(Icons.search)),
            //  IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(10.0),
            ),
          ),
//      actions: [Icon(Icons.dehaze)],
        ),
        body:
            //  HorizontalButtonBar(),
            FutureBuilder(
                future: favController.getPeople(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) print('');
                  var data = snapshot.data as List<dynamic>;
                  //FavoriteModle favoriteModle=data.
                  // int num=data.length;
                  return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        idDelet = data[index].id;
                        if (data.length == 0) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return ListTile(
                            leading: Image.asset("images/books_pile.PNG"),
                            title: Text('${data[index].name}'),
                            subtitle: Text('${data[index].id}'),
                            trailing: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                setState(() {
                                  favController.deleteFaveorte(data[index].id);
                                });
                              },
                            ),
                          );
                        }
                      });
                }));
  }
}
