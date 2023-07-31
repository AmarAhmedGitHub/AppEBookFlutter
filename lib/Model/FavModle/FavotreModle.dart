// apiResponse.data = jsonDecode(response.body)['category']
//           .map((p) => BookCategory.fromJson(p))
//           .toList();

class FavotreBook {
  int? id;
  String? name;
  int? type=1;
  // int? catId;
  // String? publisher;
  // String? language;
  // String? yaer;
  // int? issn;
  FavotreBook({this.id, this.name, this.type
      // this.catId,
      // this.publisher,
      // this.language,
      // this.yaer,
      //this.issn
      });
// int? get id =>_id;
// String? get name =>_name;

  FavotreBook.fromMapObject(Map<dynamic, dynamic> map) {
    //  return FavotreBook(
    this.id = map['id'];
    this.name = map['name'];
    this.type = map['type'];
//      catId: json['category_book_id'],
    //     publisher: json['publisher'],
    //   language: json['language'],
    // yaer: json['yaer'],
  }

  Map<String, dynamic> toMapFav() {
    var map = <String, dynamic>{
      'id': id,
      'name': name,
      'type': type,
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
