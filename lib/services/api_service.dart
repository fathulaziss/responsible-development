// ignore_for_file: only_throw_errors

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:responsible_development/common/enum.dart';
import 'package:responsible_development/models/response_model.dart';
import 'package:responsible_development/utils/app_config.dart';
import 'package:responsible_development/utils/app_storage.dart';
import 'package:responsible_development/utils/app_utils.dart';

class ApiService {
  Future<ResponseModel> request({
    required String endPoint,
    required Method method,
    Map<String, String>? headers,
    dynamic body,
    bool useToken = true,
  }) async {
    http.Response response;

    final baseUrl = AppConfig.baseUrl;

    final url = Uri.parse('$baseUrl$endPoint');

    // final params = body ?? <String, dynamic>{};

    final header = await getHeader(headers: headers, useToken: useToken);

    try {
      if (method == Method.post) {
        response = await http.post(url, body: body, headers: header);
      } else if (method == Method.delete) {
        response = await http.delete(url);
      } else if (method == Method.patch) {
        response = await http.patch(url);
      } else {
        response = await http.get(url, headers: header);
      }

      AppUtils.logger('url : $url');
      AppUtils.logger('body : $body');
      AppUtils.logger('response : ${response.body}');

      final data = ResponseModel.fromJson(jsonDecode(response.body));

      return data;
    } on SocketException {
      AppUtils.logger('Tidak Ada Koneksi Internet');
      throw 'Tidak Ada Koneksi Internet';
    } on HttpException {
      AppUtils.logger('Tidak Ada Koneksi Internet');
      throw 'Tidak Ada Koneksi Internet';
    } on FormatException {
      AppUtils.logger('Response Format Gagal');
      throw 'Response Format Gagal';
    } catch (e) {
      throw '$e';
    }
  }

  Future<http.StreamedResponse> requestMultipart({
    required String endPoint,
    required http.MultipartFile multipartFile,
  }) async {
    final baseUrl = AppConfig.baseUrl;

    final url = Uri.parse('$baseUrl$endPoint');

    final header = await getHeaderMultipart();

    final request = http.MultipartRequest('POST', url);
    request.headers.addAll(header);
    request.files.add(multipartFile);

    try {
      AppUtils.logger('url : $url');
      return await request.send();
    } on SocketException {
      AppUtils.logger('Tidak Ada Koneksi Internet');
      throw 'Tidak Ada Koneksi Internet';
    } on HttpException {
      AppUtils.logger('Tidak Ada Koneksi Internet');
      throw 'Tidak Ada Koneksi Internet';
    } on FormatException {
      AppUtils.logger('Response Format Gagal');
      throw 'Response Format Gagal';
    } catch (e) {
      throw '$e';
    }
  }

  Future<Map<String, String>> getHeader({
    Map<String, String>? headers,
    required bool useToken,
  }) async {
    final header = headers ??
        <String, String>{
          'Content-type': 'application/x-www-form-urlencoded',
          'Accept': 'application/json',
        };

    // final header = <String, String>{
    //   'Content-type': 'application/json',
    //   'Accept': 'application/json',
    // };

    final token = await AppStorage.read(key: 'token');

    if (useToken) {
      header['Authorization'] = 'Bearer $token';
    }

    return header;
  }

  Future<Map<String, String>> getHeaderMultipart() async {
    final token = await AppStorage.read(key: 'token');
    final header = <String, String>{
      'Media-type': 'multipart/form-data',
      'Authorization': 'Bearer $token',
    };

    return header;
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
