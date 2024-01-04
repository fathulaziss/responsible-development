class ResponseModel {
  const ResponseModel({
    this.success = false,
    this.message = '',
    this.code = 0,
    this.data,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
        success: json['success'] ?? false,
        message: json['message'] ?? '',
        code: json['code'] ?? 0,
        data: json['data'],
      );

  final bool success;
  final String message;
  final int code;
  final dynamic data;

  Map<String, dynamic> toJson() {
    final tempData = <String, dynamic>{};

    tempData['success'] = success;
    tempData['message'] = message;
    tempData['code'] = code;
    tempData['data'] = data;

    return tempData;
  }

  @override
  String toString() {
    return 'ResponseModel(success: $success, message: $message, code: $code, data: $data)';
  }
}
