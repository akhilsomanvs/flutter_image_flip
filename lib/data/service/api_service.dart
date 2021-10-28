import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:image_flip/data/repositories/api/api_exception.dart';

class ApiService {
  static const String _apiUrl = "https://api.imgflip.com/get_memes";

  static Future<dynamic> fetchMemes() async {
    var responseJson;
    try {
      final response = await http.get(Uri.parse(_apiUrl));
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  static dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
