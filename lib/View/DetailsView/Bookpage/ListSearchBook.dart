import 'package:flutter/material.dart';
import 'package:library/Model/BookModle/BookModle.dart';
import 'package:library/View/DetailsView/Bookpage/readBook.dart';
import 'package:get/get.dart';

class BooksList extends StatefulWidget {
  //var price ;
  //final country ;
//final  String name;
  final Book? book;
  BooksList(
      {

      // this.country ,
      this.book});

  @override
  _BooksListState createState() => _BooksListState();
}

class _BooksListState extends State<BooksList> {
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
                child: widget.book!.image != null
                    ? Image.network('http://192.168.0.191:8000/storage/ebook/' +
                        widget.book!.image!)
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
                          child: Text(widget.book!.name!,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w800),
                              textAlign: TextAlign.center),
                        ),
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              Text(
                                "", // "name : " + '${book!.name}',
                                style: TextStyle(color: Colors.grey),
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
        Get.to(ReadBook(widget.book!, '${widget.book!.name}'));
      },
    );
  }
}
