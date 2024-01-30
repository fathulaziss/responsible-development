import 'package:flutter/material.dart';
import 'package:responsible_development/data/project_dummy.dart';
import 'package:responsible_development/models/project_model.dart';

class SyncRepository {
  static Future<void> syncRDProject({
    required ValueSetter<List<ProjectModel>> onSuccess,
    required ValueSetter<String> onError,
  }) async {
    try {
      // var endPoint = ApiEndpoint.project;

      // final response =
      //     await ApiService().request(endPoint: endPoint, method: Method.get);

      // if (response.success) {
      //   final data = AgentDataModel.fromJson(response.data);
      //   onSuccess(data);
      // } else {
      //   onError(response.message);
      // }
      await Future.delayed(const Duration(seconds: 3));
      final response = projectDummy;
      if (response.isNotEmpty) {
        final data =
            List<ProjectModel>.from(response.map(ProjectModel.fromMap));
        onSuccess(data);
      } else {
        onError('Data Tidak Ditemukan');
      }
    } catch (e) {
      onError(e.toString());
      rethrow;
    }
  }
}
