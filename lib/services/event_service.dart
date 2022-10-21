import 'dart:convert';

import 'package:dharmlok/models/bal_vidya_model.dart';
import 'package:dharmlok/models/event_model.dart';

import '../constants/AppStrings.dart';
import 'package:dio/dio.dart';
import '../helpers/error_handler.dart';
import '../helpers/http_service.dart';

class EventService {

  final HttpService httpService = HttpService();

  Future<List<EventModel>> getAllEvents(String category, String token) async {
    try {
      final Map<String, dynamic> _header = <String, dynamic>{
        "token" : token
      };
      final Map<String, dynamic> map = <String, dynamic>{
        'category': category,
      };
      final Response<dynamic> response = await httpService.postUrl(AppStrings.apiUrl + 'getevents', map, _header);
      var jsonString = response.data as Map<String, dynamic>;
      return jsonString['message']
          .map<EventModel>((json) => EventModel.fromJson(json))
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
