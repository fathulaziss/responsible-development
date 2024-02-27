import 'dart:convert';

import 'package:responsible_development/models/project_model.dart';

class MyProjectModel {
  MyProjectModel({this.userId, this.percentage, this.project});

  factory MyProjectModel.fromMap(Map<String, dynamic> map) {
    return MyProjectModel(
      userId: map['user_id'],
      percentage: map['percentage'],
      project: map['project'] != null
          ? ProjectModel.fromMap(map['project'])
          : const ProjectModel(),
    );
  }

  factory MyProjectModel.fromDatabase(Map<String, dynamic> database) {
    return MyProjectModel(
      userId: database['user_id'],
      percentage: database['percentage'],
      project: ProjectModel(
        id: database['project_id'],
        category: database['project_category'],
        name: database['project_name'],
        dic: jsonDecode(database['project_dic']) != null
            ? List<String>.from(
                (jsonDecode(database['project_dic']) as List)
                    .map((e) => e.toString()),
              )
            : [],
        pic: jsonDecode(database['project_pic']) != null
            ? List<String>.from(
                (jsonDecode(database['project_pic']) as List)
                    .map((e) => e.toString()),
              )
            : [],
        location: jsonDecode(database['project_location']) != null
            ? List<String>.from(
                (jsonDecode(database['project_location']) as List)
                    .map((e) => e.toString()),
              )
            : [],
      ),
    );
  }

  String? userId;
  double? percentage;
  ProjectModel? project;

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'percentage': percentage,
      'project': project?.toMap(),
    };
  }

  Map<String, dynamic> toDatabase() {
    return {
      'user_id': userId,
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
