import 'dart:convert';

import 'package:dharmlok/models/vendor_model.dart';

import '../constants/AppStrings.dart';
import 'package:dio/dio.dart';
import '../helpers/error_handler.dart';
import '../helpers/http_service.dart';

class VendorService {
  final HttpService httpService = HttpService();

  Future<List<VendorModel>> getAllVendor(String category, String typeVendor, String token) async {
    try {
      final Map<String, dynamic> _header = <String, dynamic>{
        "token" : token
      };
      final Map<String, dynamic> map = <String, dynamic>{
        'category': category,
        'typeVendor': typeVendor
      };
      final Response<dynamic> response = await httpService.postUrl(AppStrings.apiUrl + 'vendor', map, _header);
      var jsonString = response.data as Map<String, dynamic>;
      return jsonString['message']
          .map<VendorModel>((json) => VendorModel.fromJson(json))
          .toList();
    } on DioError catch (error) {
      if (error.type == DioErrorType.receiveTimeout ||
          error.type == DioErrorType.connectTimeout) {
        throw ShowError('Server timeout');
      } else {
        throw ShowError('We are working at backend. Please try again in few minutes');
      }
    }
  }

  Future<Map<String,dynamic>> getDetails(String id, String token) async {
    try {
      final Map<String, dynamic> _header = <String, dynamic>{
        "token" : token
      };
      final Map<String, dynamic> map = <String, dynamic>{
        'id': id,
        //'typeVendor': typeVendor
      };
      final Response<dynamic> response = await httpService.getUrl(AppStrings.apiUrl + 'mydetails', map, _header);
      return response.data as Map<String,dynamic>;
    } on DioError catch (error) {
      if (error.type == DioErrorType.receiveTimeout ||
          error.type == DioErrorType.connectTimeout) {
        throw ShowError('Server timeout');
      } else {
        throw ShowError('We are working at backend. Please try again in few minutes');
      }
    }
  }



  Future<Map<dynamic,dynamic>> getPDetails() async {
    try {
      final Map<String, dynamic> _header = <String, dynamic>{
        "token" : ''
      };
      final Map<String, dynamic> map = <String, dynamic>{
        'id': 'id',
        //'typeVendor': typeVendor
      };
      final Response<dynamic> response = await httpService.getUrl(AppStrings.apiUrl + 'getpanchang', map, _header);
      print('this is panchang resp' + response.data.toString());
      return response.data as Map<dynamic,dynamic>;
    } on DioError catch (error) {
      if (error.type == DioErrorType.receiveTimeout ||
          error.type == DioErrorType.connectTimeout) {
        throw ShowError('Server timeout');
      } else {
        throw ShowError('We are working at backend. Please try again in few minutes');
      }
    }
  }
}
