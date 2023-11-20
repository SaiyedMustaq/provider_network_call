import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:network_layer_provider/network_module/api_exception.dart';

import 'api_base.dart';

enum REQUESTMETHOD { GET, POST, PUT, DELETE }

class HttpClient {
  static final HttpClient _httpClientSingleton = HttpClient();

  static HttpClient get instance => _httpClientSingleton;

  Future<dynamic> request({
    required BuildContext context,
    required REQUESTMETHOD methodType,
    required dynamic requestData,
    required String endPoint,
  }) async {
    var header = {HttpHeaders.contentTypeHeader: 'appliction/json'};
    switch (methodType) {
      case REQUESTMETHOD.GET:
        final response = await http.get(Uri.parse(endPoint), headers: header);
        return _returnResponseJson(response);
      case REQUESTMETHOD.POST:
        final response = await http.post(Uri.parse(endPoint),
            headers: header, body: requestData);
        return _returnResponseJson(response);
      case REQUESTMETHOD.PUT:
        final response = await http.put(Uri.parse(endPoint),
            headers: header, body: requestData);
        return _returnResponseJson(response);
      case REQUESTMETHOD.DELETE:
        final response = await http.put(Uri.parse(endPoint),
            headers: header, body: requestData);
        return _returnResponseJson(response);
      default:
    }
  }

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
    final jsonString = Uri(queryParameters: param);
    return jsonString.toString();
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
