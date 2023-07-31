import 'package:flutter/cupertino.dart';

class CategoryEBook {
  int? id;
  String? name;
  String? description;
  List<EBook>? ebook;

  CategoryEBook({this.id, this.name, this.description, this.ebook});

// map json to post model

  factory CategoryEBook.fromJson(Map<String, dynamic> json) {
    var tagObjsJson = json['ebooks'] as List;
    List<EBook> _tags =
        tagObjsJson.map((tagJson) => EBook.fromJson(tagJson)).toList();
    return CategoryEBook(id: json['id'], name: json['name'], ebook: _tags);
  }
}

class EBook {
  int? id;
  String? name;
  String? issn;
  String? author;
  String? publisher;
  String? language;
  String? yaer;
  String? path;
  int? catId;
  String? image;
  int? type = 2;

  EBook({
    this.id,
    this.name,
    this.issn,
    this.author,
    this.publisher,
    this.language,
    this.yaer,
    this.catId,
    this.path,
    this.image
  });

  factory EBook.fromJson(Map<String, dynamic> json) {
    return EBook(
      id: json['id'],
      name: json['name'],
      issn: json['issn'],
      author: json['author'],
      publisher: json['publisher'],
      language: json['language'],
      yaer: json['year'],
      path: json['path'],
      catId: json['category_ebook_id'],
      image: json['image']
    );
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'name': name,
      'issn': issn,
      'author': author,
      'publisher': publisher,
      'language': language,
      'path': path,
      'category_ebook_id': catId,
    };
    return map;
  }

  Map<String, dynamic> toMapFav() {
    var map = <String, dynamic>{
      'id': id,
      'name': name,
      'type': type
      // 'issn': issn,
      // 'author': author,
      // 'publisher': publisher,
      // 'quantity': quantity,
      // 'language': language,
      // 'category_book_id': catId,
    };
    return map;
  }
}
