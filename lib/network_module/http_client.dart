import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:network_layer_provider/network_module/api_exception.dart';

import 'api_base.dart';

class HttpClient {
  static final HttpClient _httpClientSingleton = HttpClient();

  static HttpClient get instance => _httpClientSingleton;

  Future<dynamic> fetchData({String? url, Map<String, String>? request}) async {
    var responseJson;

    var uri = APIBase.baseUrl +
        url! +
        ((request != null) ? this.queryParams(request) : "");
    var header = {HttpHeaders.contentTypeHeader: 'appliction/json'};

    try {
      final response = await http.get(Uri.parse(uri), headers: header);
      responseJson = _returnResponseJson(response);
    } on SocketException {
      throw FetchDataException('No Internet Available');
    }
    return responseJson;
  }

  String queryParams(Map<String, String> param) {
    if (param != null) {
      final jsonString = Uri(queryParameters: param);
      return jsonString.toString();
    }
    return '';
  }

  dynamic _returnResponseJson(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseReturn = jsonDecode(response.body.toString());
        return responseReturn;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
        throw FetchDataException(
            'Error occured while communicate with Statecode :${response.statusCode} ');
    }
  }
}
