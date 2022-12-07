import '../constants/AppStrings.dart';
import 'package:dio/dio.dart';
import '../helpers/error_handler.dart';
import '../helpers/http_service.dart';
import '../models/dharmshala_model.dart';

class DharmshalaService {
  final HttpService httpService = HttpService();

  Future<List<DharmshalaModel>> getDharmshala(String category, String city,String language, String state, String token) async {
    try {
      final Map<String, dynamic> _header = <String, dynamic>{
        "token" : token
      };
      final Map<String, dynamic> map = <String, dynamic>{
        'category': category,
        'language': language,
        'city' : city,
        'state':state
      };
      final Response<dynamic> response = await httpService.postUrl(AppStrings.apiUrl + 'getalldharamshala',map, _header);
      var jsonString = response.data as Map<String, dynamic>;
      return jsonString['message']
          .map<DharmshalaModel>((json) => DharmshalaModel.fromJson(json))
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

  Future<Map<String, dynamic>> addEnquiry(String name, String email,
      String date, String description,
      String duration, String numberOfPerson, token, String phone, String type) async {
    try {
      final Map<String, dynamic> _header = <String, dynamic>{
        "token" : token
      };
      final Map<String, dynamic> map = <String, dynamic>{
        'description' : description,
        'country' : 'India',
        'date': date,
        'duration': duration,
        'name': name,
        'id':'',
        'phone': phone,
        'email' : email,
        'person': numberOfPerson,
        'type': type,
      };
      final Response<dynamic> response = await httpService.postUrl(AppStrings.apiUrl + 'addbooking',map, _header);
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
}
