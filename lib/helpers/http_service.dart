import 'dart:convert';
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';

class HttpService {
  Dio dio = Dio();

  Future<Response<dynamic>> postUrl(String url, Map<String, dynamic> data,
      Map<String, dynamic>? headers) async {
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient dioClient) {
      dioClient.badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
      return dioClient;
    };
    return dio.post(url,
        data: json.encode(data),
        options: Options(
            headers: headers, receiveTimeout: 10 * 1000, sendTimeout: 8 * 1000));
  }

  Future<Response<dynamic>> getUrl(String url, Map<String, dynamic> data,
      Map<String, dynamic>? headers) async {
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient dioClient) {
      dioClient.badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
      return dioClient;
    };
    return dio.get(url,
        options: Options(
            headers: headers, receiveTimeout: 10 * 1000, sendTimeout: 8 * 1000));
  }
}
