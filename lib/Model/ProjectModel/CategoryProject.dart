
class ProjectCategory {
  int? id;
  String? name;
  String? description;
  List<Project>? project;

  ProjectCategory({this.id, this.name, this.description, this.project});

// map json to post model

  factory ProjectCategory.fromJson(Map<String, dynamic> json) {
    var tagObjsJson = json['projects'] as List;
    List<Project> _tags =
        tagObjsJson.map((tagJson) => Project.fromJson(tagJson)).toList();
    return ProjectCategory(id: json['id'], name: json['name'], project: _tags);
  }
}

class Project {
  int? id;
  String? name;
  String? supervisor;
  int? quantity;
  String? language;
  String? yaer;
  String? path;
  int? catId;
  int? type = 3;
  String? image;

  Project(
      {this.id,
      this.name,
      this.supervisor,
      this.quantity,
      this.language,
      this.yaer,
      this.catId,
      this.path,
      this.image});

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'],
      name: json['name'],
      supervisor: json['supervisor'],
      quantity: json['quantity'],
      language: json['language'],
      yaer: json['yaer'],
      path: json['file_path'],
      catId: json['category_project_id'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'name': name,
      'supervisor': supervisor,
      'quantity': quantity,
      'language': language,
      'year': yaer,
      'file_path': path,
      'category_project_id': catId,
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
