import 'dart:convert';

import 'package:equatable/equatable.dart';

class ProjectModel extends Equatable {
  const ProjectModel({
    this.id,
    this.category,
    this.name,
    this.dic,
    this.pic,
    this.location,
    this.periode,
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
              (map['location'] as List).map((e) => e.toString()),
            )
          : [],
      periode: map['periode'] != null
          ? List<String>.from(
              (map['periode'] as List).map((e) => e.toString()),
            )
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
              (jsonDecode(database['dic']) as List).map((e) => e.toString()),
            )
          : [],
      pic: jsonDecode(database['pic']) != null
          ? List<String>.from(
              (jsonDecode(database['pic']) as List).map((e) => e.toString()),
            )
          : [],
      location: jsonDecode(database['location']) != null
          ? List<String>.from(
              (jsonDecode(database['location']) as List)
                  .map((e) => e.toString()),
            )
          : [],
      periode: jsonDecode(database['periode']) != null
          ? List<String>.from(
              (jsonDecode(database['periode']) as List)
                  .map((e) => e.toString()),
            )
          : [],
    );
  }

  final String? id;
  final String? category;
  final String? name;
  final List<String>? dic;
  final List<String>? pic;
  final List<String>? location;
  final List<String>? periode;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category': category,
      'name': name,
      'dic': List.from(dic!.map((e) => e)),
      'pic': List.from(pic!.map((e) => e)),
      'location': List.from(location!.map((e) => e)),
      'periode': List.from(periode!.map((e) => e)),
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
      'periode': jsonEncode(periode),
    };
  }

  @override
  String toString() {
    return 'ProjectModel(id: $id, category: $category, name: $name, dic: $dic, pic: $pic, location: $location, periode: $periode)';
  }

  @override
  List<Object?> get props => [id, category, name, dic, pic, location, periode];
}
