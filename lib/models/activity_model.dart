import 'dart:convert';

import 'package:equatable/equatable.dart';

class ActivityModel extends Equatable {
  const ActivityModel({
    this.id = '',
    this.userId = '',
    this.date = '',
    this.projectId = '',
    this.projectName = '',
    this.startTime = '',
    this.finishTime = '',
    this.description = '',
    this.attachments = const [],
    this.isSynchronize = 0,
    this.createdAt = '',
    this.updatedAt = '',
  });

  factory ActivityModel.fromMap(Map<String, dynamic> map) {
    return ActivityModel(
      id: map['id'],
      userId: map['user_id'],
      date: map['date'],
      projectId: map['project_id'],
      projectName: map['project_name'],
      startTime: map['start_time'],
      finishTime: map['finish_time'],
      description: map['description'],
      attachments: map['attachments'] != null
          ? List.from((map['attachments'] as List).map((e) => e))
          : [],
      isSynchronize: map['is_synchronize'],
      createdAt: map['created_at'],
      updatedAt: map['updated_at'],
    );
  }

  factory ActivityModel.fromDatabase(Map<String, dynamic> database) {
    return ActivityModel(
      id: database['id'],
      userId: database['user_id'],
      date: database['date'],
      projectId: database['project_id'],
      projectName: database['project_name'],
      startTime: database['start_time'],
      finishTime: database['finish_time'],
      description: database['description'],
      attachments: database['attachments'] != null
          ? List.from(
              (jsonDecode(database['attachments']) as List).map((e) => e),
            )
          : [],
      isSynchronize: database['is_synchronize'],
      createdAt: database['created_at'],
      updatedAt: database['updated_at'],
    );
  }

  final String id;
  final String userId;
  final String date;
  final String projectId;
  final String projectName;
  final String startTime;
  final String finishTime;
  final String description;
  final List attachments;
  final int isSynchronize;
  final String createdAt;
  final String updatedAt;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'date': date,
      'project_id': projectId,
      'project_name': projectName,
      'start_time': startTime,
      'finish_time': finishTime,
      'description': description,
      'attachments': List.from(attachments.map((e) => e)),
      'is_synchronize': isSynchronize,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  Map<String, dynamic> toDatabase() {
    return {
      'id': id,
      'user_id': userId,
      'date': date,
      'project_id': projectId,
      'project_name': projectName,
      'start_time': startTime,
      'finish_time': finishTime,
      'description': description,
      'attachments': jsonEncode(List.from(attachments.map((e) => e))),
      'is_synchronize': isSynchronize,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  @override
  String toString() {
    return 'ActivityModel(id: $id, user_id: $userId, date: $date, project_id: $projectId, project_name: $projectName, start_time: $startTime, finish_time: $finishTime, description: $description, attachments: $attachments, is_synchronize: $isSynchronize, created_at: $createdAt, updated_at: $updatedAt)';
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        date,
        projectId,
        projectName,
        startTime,
        finishTime,
        description,
        attachments,
        isSynchronize,
        createdAt,
        updatedAt,
      ];
}
