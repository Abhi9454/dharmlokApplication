import 'dart:convert';

import 'package:dharmlok/models/audio_track_model.dart';

import '../models/audio_playlist_model.dart';
import '../models/bal_vidya_model.dart';
import '../models/ebook_model.dart';

import '../constants/AppStrings.dart';
import 'package:dio/dio.dart';
import '../helpers/error_handler.dart';
import '../helpers/http_service.dart';

class AudioService {
  final HttpService httpService = HttpService();

  Future<List<AudioPlayListModel>> getAllAudio(String token) async {
    print("function called");
    try {
      final Map<String, dynamic> _header = <String, dynamic>{
        "token" : token
      };
      final Map<String, dynamic> map = <String, dynamic>{
      };
      final Response<dynamic> response = await httpService.getUrl(AppStrings.apiUrl + 'getaudiocategory',map, _header);
      var jsonString = response.data as Map<String, dynamic>;
      return jsonString['message']
          .map<AudioPlayListModel>((json) => AudioPlayListModel.fromJson(json))
          .toList();
    } on DioError catch (error) {
      if (error.type == DioErrorType.receiveTimeout ||
          error.type == DioErrorType.connectTimeout) {
        throw ShowError('Server timeout ');
      } else {
        throw ShowError('Something went wrong');
      }
    }
  }

  Future<List<AudioTrackModel>> getPlayListAudio(String token) async {
    print("function called");
    try {
      final Map<String, dynamic> _header = <String, dynamic>{
        "token" : token
      };
      final Map<String, dynamic> map = <String, dynamic>{
      };
      final Response<dynamic> response = await httpService.getUrl(AppStrings.apiUrl + 'getallaudio',map, _header);
      var jsonString = response.data as Map<String, dynamic>;
      print("this is audio track response " + response.data.toString());
      return jsonString['message']
          .map<AudioTrackModel>((json) => AudioTrackModel.fromJson(json))
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
