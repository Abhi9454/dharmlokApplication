import '../constants/AppStrings.dart';
import 'package:dio/dio.dart';
import '../helpers/error_handler.dart';
import '../helpers/http_service.dart';

class TempleService {
  final HttpService httpService = HttpService();

  Future<Map<String,dynamic>> getAllTemples(String category,String city, String language,String location, String state, String token) async {
    try {
      final Map<String, dynamic> _header = <String, dynamic>{
        "token" : token
      };
      final Map<String, dynamic> map = <String, dynamic>{
        'category': category,
        'language': language,
        'city' : location,
        'location':location,
        'state':state
      };
      final Response<dynamic> response = await httpService.postUrl(AppStrings.apiUrl + 'getalltemples',map, _header);
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
