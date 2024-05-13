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
      isSynchronize: map['is_synchronize'],
      createdAt: map['created_at'],
      updatedAt: map['updated_at'],
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
      'is_synchronize': isSynchronize,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  @override
  String toString() {
    return 'ActivityModel(id: $id, user_id: $userId, date: $date, project_id: $projectId, project_name: $projectName, start_time: $startTime, finish_time: $finishTime, description: $description, is_synchronize: $isSynchronize, created_at: $createdAt, updated_at: $updatedAt)';
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
        isSynchronize,
        createdAt,
        updatedAt,
      ];
}
