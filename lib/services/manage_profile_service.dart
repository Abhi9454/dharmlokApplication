import '../models/ebook_model.dart';

import '../constants/AppStrings.dart';
import 'package:dio/dio.dart';
import '../helpers/error_handler.dart';
import '../helpers/http_service.dart';

class ManageProfileService {
  final HttpService httpService = HttpService();

  Future<Map<String,dynamic>> updateProfile(String imageUrl, String fullName,String email,String phone, String city, String state, String fullAddress, String token) async {
    try {
      final Map<String, dynamic> _header = <String, dynamic>{
        "token" : token
      };
      final Map<String, dynamic> map = <String, dynamic>{
      };
      final Response<dynamic> response = await httpService.postUrl(AppStrings.apiUrl + 'getallebook',map, _header);
      var jsonString = response.data as Map<String, dynamic>;
      print("this is reponse" + jsonString.toString());
      return jsonString['message']
          .map<EbookModel>((json) => EbookModel.fromJson(json))
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


  Future<Map<String,dynamic>> getAllStates(String token) async {
    try {
      final Map<String, dynamic> _header = <String, dynamic>{
        "token" : token
      };
      final Map<String, dynamic> map = <String, dynamic>{
      };
      final Response<dynamic> response = await httpService.getUrl(AppStrings.apiUrl + 'getstate',map, _header);
      print('this is response' + response.data.toString());
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

  Future<Map<String,dynamic>> getAllCities(String state,String token) async {
    try {
      final Map<String, dynamic> _header = <String, dynamic>{
        "token" : token
      };
      final Map<String, dynamic> map = <String, dynamic>{
        'state': state
      };
      final Response<dynamic> response = await httpService.postUrl(AppStrings.apiUrl + 'getcities',map, _header);
      var jsonString = response.data as Map<String, dynamic>;
      print("this is reponse" + jsonString.toString());
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
}
