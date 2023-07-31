class BookCategory {
  int? id;
  String? name;
  String? description;
  List<Book>? book;

  BookCategory({this.id, this.name, this.description, this.book});

// map json to post model

  factory BookCategory.fromJson(Map<String, dynamic> json) {
    var tagObjsJson = json['books'] as List;
    List<Book> _tags =
        tagObjsJson.map((tagJson) => Book.fromJson(tagJson)).toList();
    return BookCategory(id: json['id'], name: json['name'], book: _tags);
  }
}

class Book {
  int? id;
  String? name;
  String? issn;
  String? author;
  String? publisher;
  int? quantity;
  String? language;
  String? yaer;
  int? catId;
  String? image;
  int? type = 1;

  Book(
      {this.id,
      this.name,
      this.issn,
      this.author,
      this.publisher,
      this.quantity,
      this.language,
      this.yaer,
      this.catId,
      this.image});

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      name: json['name'],
      issn: json['issn'],
      author: json['author'],
      publisher: json['publisher'],
      quantity: json['quantity'],
      language: json['language'],
      yaer: json['year'],
      catId: json['category_book_id'],
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
      'quantity': quantity,
      'language': language,
      'category_book_id': catId,
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
