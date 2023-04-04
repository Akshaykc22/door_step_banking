import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';

import '../door_step_banking/data/remote_routes/app_remote_routes.dart';
import 'custom_exception.dart';

class ApiProvider {
  late Dio _dio;

  ApiProvider() {
    _dio = Dio(
      BaseOptions(
        validateStatus: (status) {
          return true;
        },
        followRedirects: false,
        headers: {
          "access-control-allow-origin": "*",
          // "Acce
          // ss-Control-Allow-Origin": "*",
          // "Access-Control-Allow-Credentials": false,
          'Content-Type': 'application/json'
        },
        baseUrl: AppRemoteRoutes.baseUrl,
        connectTimeout: const Duration(minutes: 2),
        receiveTimeout: const Duration(minutes: 2),
      ),
    );
    if (!kIsWeb) {
      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
    }
  }

  Future<Map<String, dynamic>> get(String endPoint) async {
    try {
      // GetStorage sr = GetStorage();
      // String? token = sr.read('token');
      // print(token);
      // _dio.options.headers.addAll({'Authorization': 'Token $token'});
      final Response response = await _dio.get(
        endPoint,
      );

      final Map<String, dynamic> responseData = classifyResponse(response);
      return responseData;
    } on DioError catch (err) {
      throw BadRequestException("Please check your connection.");
    }
  }

  Future<Map<String, dynamic>> post(
      String endPoint, Map<String, dynamic> body) async {
    try {
      GetStorage sr = GetStorage();
      String? token = sr.read('token');

      if (token != null) {
        _dio.options.headers.addAll({'Authorization': 'Token $token'});
      }

      final Response response = await _dio.post(
        endPoint,
        data: body,
      );

      final Map<String, dynamic> responseData = classifyResponse(response);

      return responseData;
    } on DioError catch (err) {
      throw FetchDataException("internetError");
    }
  }

  Future<Map<String, dynamic>> put(
      String endPoint, Map<String, dynamic> body) async {
    try {
      GetStorage sr = GetStorage();
      String? token = sr.read('token');

      _dio.options.headers.addAll({'Authorization': 'Token $token'});

      final Response response = await _dio.put(
        endPoint,
        data: body,
      );

      final Map<String, dynamic> responseData = classifyResponse(response);

      return responseData;
    } on DioError catch (err) {
      throw FetchDataException("internetError");
    }
  }

  // Future<Uint8List> download({required String imageUrl}) async {
  //   final tempStorage = await getTemporaryDirectory();
  //   final data = await _dio.download(imageUrl, tempStorage.path);
  //   final d = data.data;
  // }

  Map<String, dynamic> classifyResponse(Response response) {
    // print(response);
    final Map<String, dynamic> responseData =
        response.data as Map<String, dynamic>;

    switch (response.statusCode) {
      case 200:
      case 201:
        return responseData;
      case 400:
        throw BadRequestException(responseData.toString());
      case 401:
        throw UnauthorisedException(responseData.toString());
      case 500:
      default:
        throw FetchDataException(
          'Error occurred while Communication with Server with StatusCode : ${response.statusCode}',
        );
    }
  }
}
