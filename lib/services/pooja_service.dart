import 'dart:convert';

import 'package:dharmlok/models/pandit_details_model.dart';
import 'package:dharmlok/models/pandit_service_model.dart';

import '../constants/AppStrings.dart';
import 'package:dio/dio.dart';
import '../helpers/error_handler.dart';
import '../helpers/http_service.dart';

class PoojaService {
  final HttpService httpService = HttpService();

  Future<Map<String,dynamic>> getAllPooja(String city,String location,String services, String state,String type, String token) async {
    try {
      final Map<String, dynamic> _header = <String, dynamic>{
        "token" : token
      };
      final Map<String, dynamic> map = <String, dynamic>{
        'city' : location,
        'location':location,
        'services':services,
        'state':state,
        'type': type
      };
      final Response<dynamic> response = await httpService.postUrl(AppStrings.apiUrl + 'getservicepandit',map, _header);
      return response.data as Map<String, dynamic>;
    } on DioError catch (error) {
      if (error.type == DioErrorType.receiveTimeout ||
          error.type == DioErrorType.connectTimeout) {
        throw ShowError('Server timeout ');
      } else {
        throw ShowError('We are working at backend. Please try again in few minutes');
      }
    }
  }


  Future<PanditDetails> getPanditDetails(String id, String token) async {
    try {
      final Map<String, dynamic> _header = <String, dynamic>{
        "token" : token
      };
      print('This is pandit id ${id}');
      final Map<String, dynamic> map = <String, dynamic>{
        'id' : id,
      };
      final Response<dynamic> response = await httpService.postUrl(AppStrings.apiUrl + 'getservicedetail',map, _header);
      print('This is pandit details ${response.data}');
      return PanditDetails.fromJson(response.data as Map<String,dynamic>);
    } on DioError catch (error) {
      if (error.type == DioErrorType.receiveTimeout ||
          error.type == DioErrorType.connectTimeout) {
        throw ShowError('Server timeout ');
      } else {
        throw ShowError('We are working at backend. Please try again in few minutes');
      }
    }
  }

  Future<Map<String, dynamic>> addEnquiry(String name, String phone,
      String date, String poojaName,
      String providerId, String serviceId, String state, String token, String city) async {
    try {
      final Map<String, dynamic> _header = <String, dynamic>{
        "token" : token
      };
      final Map<String, dynamic> map = <String, dynamic>{
        'city' : city,
        'country' : 'India',
        'date': date,
        'id': serviceId,
        'name': name,
        'phone': phone,
        'poojaname' : poojaName,
        'providerId': providerId,
        'serviceId': serviceId,
        'state': state
      };
      final Response<dynamic> response = await httpService.postUrl(AppStrings.apiUrl + 'addenquiry',map, _header);
      print('This is pandit details ${response.data}');
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

  Future<List<PanditService>> getPanditService(String id, String token) async {
    try {
      final Map<String, dynamic> _header = <String, dynamic>{
        "token" : token
      };
      final Map<String, dynamic> map = <String, dynamic>{
        'id' : id,
        'type':''
      };
      final Response<dynamic> response = await httpService.postUrl(AppStrings.apiUrl + 'myservice',map, _header);
      var jsonString = response.data as Map<String, dynamic>;
      print("this is pandit service resp" + jsonString.toString());
      return jsonString['message']
          .map<PanditService>((json) => PanditService.fromJson(json))
          .toList();
    } on DioError catch (error) {
      if (error.type == DioErrorType.receiveTimeout ||
          error.type == DioErrorType.connectTimeout) {
        throw ShowError('Server timeout ');
      } else {
        throw ShowError('We are working at backend. Please try again in few minutes');
      }
    }
  }

  // Future<List<PanditService>> getPanditService(String id, String token) async {
  //   try {
  //     final Map<String, dynamic> _header = <String, dynamic>{
  //       "token" : token
  //     };
  //     final Map<String, dynamic> map = <String, dynamic>{
  //       'id' : id,
  //       'type':''
  //     };
  //     final Response<dynamic> response = await httpService.postUrl(AppStrings.apiUrl + 'myservice',map, _header);
  //     var jsonString = response.data as Map<String, dynamic>;
  //     print("this is pandit service resp" + jsonString.toString());
  //     return jsonString['message']
  //         .map<PanditService>((json) => PanditService.fromJson(json))
  //         .toList();
  //   } on DioError catch (error) {
  //     if (error.type == DioErrorType.receiveTimeout ||
  //         error.type == DioErrorType.connectTimeout) {
  //       throw ShowError('Server timeout ');
  //     } else {
  //       throw ShowError('We are working at backend. Please try again in few minutes');
  //     }
  //   }
  // }
}
