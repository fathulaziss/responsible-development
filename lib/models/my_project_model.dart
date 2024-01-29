import 'dart:convert';

import 'package:responsible_development/models/project_model.dart';

class MyProjectModel {
  MyProjectModel({this.percentage, this.project});

  factory MyProjectModel.fromMap(Map<String, dynamic> map) {
    return MyProjectModel(
      percentage: map['percentage'],
      project: map['project'] != null
          ? ProjectModel.fromMap(map['project'])
          : ProjectModel(),
    );
  }

  factory MyProjectModel.fromDatabase(Map<String, dynamic> database) {
    return MyProjectModel(
      percentage: database['percentage'],
      project: ProjectModel(
        id: database['project_id'],
        category: database['project_id'],
        name: database['project_id'],
        dic: jsonDecode(database['project_dic']) != null
            ? List<String>.from((jsonDecode(database['project_dic']) as List)
                .map((e) => e.toString()))
            : [],
        pic: jsonDecode(database['project_pic']) != null
            ? List<String>.from((jsonDecode(database['project_pic']) as List)
                .map((e) => e.toString()))
            : [],
        location: jsonDecode(database['project_location']) != null
            ? List<String>.from(
                (jsonDecode(database['project_location']) as List)
                    .map((e) => e.toString()))
            : [],
      ),
    );
  }

  double? percentage;
  ProjectModel? project;

  Map<String, dynamic> toMap() {
    return {
      'percentage': percentage,
      'project': project?.toMap(),
    };
  }

  Map<String, dynamic> toDatabase() {
    return {
      'percentage': percentage,
      'project_id': project?.id,
      'project_category': project?.category,
      'project_name': project?.name,
      'project_dic': jsonEncode(project?.dic),
      'project_pic': jsonEncode(project?.pic),
      'project_location': jsonEncode(project?.location),
    };
  }
}
