import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/adapter.dart';

import '../constants/AppStrings.dart';
import 'package:dio/dio.dart';
import '../helpers/error_handler.dart';
import '../helpers/http_service.dart';

class LocationService {
  final HttpService httpService = HttpService();

  final Dio _dio = Dio();


  Future<Map<String, dynamic>> getLocationName(String lat, String lon) async {

    try {
      final Map<String, dynamic>  map = <String, dynamic>{
        'lat' : lat,
        'lon' : lon
      };
      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient dioClient) {
        dioClient.badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);
        return dioClient;
      };
      final Response<dynamic> response =
      await _dio.post(AppStrings.apiUrl + 'getuserlocation', data: map);
      return response.data as Map<String,dynamic>;
    } on DioError catch (error) {
      if (error.type == DioErrorType.receiveTimeout ||
          error.type == DioErrorType.connectTimeout) {
        throw ShowError('Server timeout ');
      } else {
        throw ShowError('We are working at backend. Please try again in few minutes');
      }
    }
  }
}
