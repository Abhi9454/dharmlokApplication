import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/adapter.dart';

import '../constants/AppStrings.dart';
import 'package:dio/dio.dart';
import '../helpers/error_handler.dart';
import '../helpers/http_service.dart';

class AuthenticateService {
  final HttpService httpService = HttpService();

  final Dio _dio = Dio();


  Future<Map<String, dynamic>> login(String email, String password) async {

    try {
      final Map<String, dynamic> _header = <String, dynamic>{
        "token" : ""
      };
      final Map<String, dynamic>  map = <String, dynamic>{
        'email' : email,
        'password' : password
      };
      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient dioClient) {
        dioClient.badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);
        return dioClient;
      };
      final Response<dynamic> response =
      await httpService.postUrl(AppStrings.apiUrl + 'login', map,_header);
      log("this is response"+response.data.toString());
      return response.data as Map<String,dynamic>;
    } on DioError catch (error) {
      if (error.type == DioErrorType.receiveTimeout ||
          error.type == DioErrorType.connectTimeout) {
        throw ShowError('Server timeout ');
      } else {
        throw ShowError('Invalid Username/Password'+error.message.toString());
      }
    }
  }

  Future<Map<String, dynamic>> register(String email, String password, String name, String phone) async {
    try {
      final Map<String, dynamic> _header = <String, dynamic>{
        "token" : ""
      };
      final Map<String, dynamic>  map = <String, dynamic>{
        'email' : email,
        'password' : password,
        'name':name,
        'phone':phone,
        'userType': 'user',
        'typeVendor': '',
        'category':''
      };
      print('This is again called');
      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient dioClient) {
        dioClient.badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);
        return dioClient;
      };
      final Response<dynamic> response =
      await httpService.postUrl(AppStrings.apiUrl + 'signup', map,_header);
      log("this is response"+response.data.toString());
      return response.data as Map<String,dynamic>;
    } on DioError catch (error) {
      if (error.type == DioErrorType.receiveTimeout ||
          error.type == DioErrorType.connectTimeout) {
        throw ShowError('Server timeout ');
      } else {
        throw ShowError('Invalid Username/Password'+error.message.toString());
      }
    }
  }

  Future<Map<String, dynamic>> forgetPassword(String email) async {

    try {
      final Map<String, dynamic> _header = <String, dynamic>{
        "token" : ""
      };
      final Map<String, dynamic>  map = <String, dynamic>{
        'email' : email,
      };
      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient dioClient) {
        dioClient.badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);
        return dioClient;
      };
      final Response<dynamic> response =
      await httpService.postUrl(AppStrings.apiUrl + 'forgetpassword', map,_header);
      log("this is response"+response.data.toString());
      return response.data as Map<String,dynamic>;
    } on DioError catch (error) {
      if (error.type == DioErrorType.receiveTimeout ||
          error.type == DioErrorType.connectTimeout) {
        throw ShowError('Server timeout ');
      } else {
        throw ShowError('Invalid Username/Password'+error.message.toString());
      }
    }
  }
}
