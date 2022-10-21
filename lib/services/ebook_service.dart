import 'dart:convert';

import '../models/bal_vidya_model.dart';
import '../models/ebook_model.dart';

import '../constants/AppStrings.dart';
import 'package:dio/dio.dart';
import '../helpers/error_handler.dart';
import '../helpers/http_service.dart';

class EbookService {
  final HttpService httpService = HttpService();

  Future<List<EbookModel>> getEbook(String category, String language,String type, String token) async {
    try {
      final Map<String, dynamic> _header = <String, dynamic>{
        "token" : token
      };
      final Map<String, dynamic> map = <String, dynamic>{
        'category': category,
        'language': language,
        'type' : type,
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
}
