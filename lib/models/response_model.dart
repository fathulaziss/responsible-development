class ResponseModel {
  const ResponseModel({
    this.success = false,
    this.message = '',
    this.data,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
        success: json['success'] ?? false,
        message: json['message'] ?? '',
        data: json['data'],
      );

  final bool success;
  final String message;
  final dynamic data;

  Map<String, dynamic> toJson() {
    final tempData = <String, dynamic>{};

    tempData['success'] = success;
    tempData['message'] = message;
    tempData['data'] = data;

    return tempData;
  }

  @override
  String toString() {
    return 'ResponseModel(success: $success, message: $message, data: $data)';
  }
}
