import 'dart:convert';

class ProjectModel {
  ProjectModel({
    this.id,
    this.category,
    this.name,
    this.dic,
    this.pic,
    this.location,
  });

  factory ProjectModel.fromMap(Map<String, dynamic> map) {
    return ProjectModel(
      id: map['id'],
      category: map['category'],
      name: map['name'],
      dic: map['dic'] != null
          ? List<String>.from((map['dic'] as List).map((e) => e.toString()))
          : [],
      pic: map['pic'] != null
          ? List<String>.from((map['pic'] as List).map((e) => e.toString()))
          : [],
      location: map['location'] != null
          ? List<String>.from(
              (map['location'] as List).map((e) => e.toString()))
          : [],
    );
  }

  factory ProjectModel.fromDatabase(Map<String, dynamic> database) {
    return ProjectModel(
      id: database['id'],
      category: database['category'],
      name: database['name'],
      dic: jsonDecode(database['dic']) != null
          ? List<String>.from(
              (jsonDecode(database['dic']) as List).map((e) => e.toString()))
          : [],
      pic: jsonDecode(database['pic']) != null
          ? List<String>.from(
              (jsonDecode(database['pic']) as List).map((e) => e.toString()))
          : [],
      location: jsonDecode(database['location']) != null
          ? List<String>.from((jsonDecode(database['location']) as List)
              .map((e) => e.toString()))
          : [],
    );
  }

  String? id;
  String? category;
  String? name;
  List<String>? dic;
  List<String>? pic;
  List<String>? location;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category': category,
      'name': name,
      'dic': List.from(dic!.map((e) => e)),
      'pic': List.from(pic!.map((e) => e)),
      'location': List.from(location!.map((e) => e)),
    };
  }

  Map<String, dynamic> toDatabase() {
    return {
      'id': id,
      'category': category,
      'name': name,
      'dic': jsonEncode(dic),
      'pic': jsonEncode(pic),
      'location': jsonEncode(location),
    };
  }

  @override
  String toString() {
    return 'ProjectModel(id: $id, category: $category, name: $name, dic: $dic, pic: $pic, location: $location)';
  }
}
