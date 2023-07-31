import 'package:flutter/material.dart';
import 'package:library/Model/ProjectModel/CategoryProject.dart';
import 'package:library/View/DetailsView/Projectpage/Projectpage.dart';
import 'package:get/get.dart';

class ProjectList extends StatelessWidget {
  //var price ;
  //final country ;
  Project? project;

  ProjectList(
      {
      // this.country ,

      this.project});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: 220,
        width: 100,
        child: Card(
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: project != null
                    ? Image.network('http://192.168.0.191:8000/storage/ebook/' +
                        '${project!.image}')
                    : Image.asset("images/books_pile.PNG"),
              ),
              Expanded(
                flex: 3,
                child: Container(
                    alignment: Alignment.topRight,
                    height: 220,
                    margin: EdgeInsets.only(right: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 10, bottom: 10),
                          child: Text(project!.name!,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w800),
                              textAlign: TextAlign.center),
                        ),
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              Text(
                                "name : " + '${project!.name}',
                                style: TextStyle(
                                    //  fontSize: _drawerFontSize,
                                    color: Theme.of(context).accentColor),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        Get.to(ReadProject(project!, project!.name!));
      },
    );
  }
}
