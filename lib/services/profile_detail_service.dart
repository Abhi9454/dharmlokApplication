import 'package:dharmlok/models/post_model.dart';
import 'package:dharmlok/models/profile_detail_model.dart';

import '../constants/AppStrings.dart';
import 'package:dio/dio.dart';
import '../helpers/error_handler.dart';
import '../helpers/http_service.dart';

class ProfileDetailService {

  final HttpService httpService = HttpService();

  Future<ProfileModel> getProfileDetail(String id, String token) async {
    try {
      final Map<String, dynamic> _header = <String, dynamic>{
        "token" : token
      };
      final Map<String, dynamic> map = <String, dynamic>{
        'id': id,
      };
      final Response<dynamic> response = await httpService.postUrl(AppStrings.apiUrl + 'getvendordetail', map, _header);
      var jsonString = response.data as Map<String, dynamic>;
      return ProfileModel.fromJson(jsonString);
    } on DioError catch (error) {
      if (error.type == DioErrorType.receiveTimeout ||
          error.type == DioErrorType.connectTimeout) {
        throw ShowError('Server timeout ');
      } else {
        throw ShowError('We are working at backend. Please try again in few minutes');
      }
    }
  }

  Future<List<PostModel>> getUserPosts(String userType, String token) async {
    try {
      final Map<String, dynamic> _header = <String, dynamic>{
        "token" : token
      };
      final Map<String, dynamic> map = <String, dynamic>{
        'userType': userType,
      };
      final Response<dynamic> response = await httpService.postUrl(AppStrings.apiUrl + 'getallpost', map,_header );
      var jsonString = response.data as Map<String, dynamic>;
      return jsonString['message']
          .map<PostModel>((json) => PostModel.fromJson(json))
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
}
