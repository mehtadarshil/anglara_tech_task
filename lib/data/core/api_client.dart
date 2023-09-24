import 'dart:convert';
import 'package:anglara_tech_task/data/core/api_constants.dart';
import 'package:anglara_tech_task/di/app_component_base.dart';
import 'package:http/http.dart';
import 'unathorised_exception.dart';

class ApiClient {
  final Client _client;

  ApiClient(this._client);

  dynamic get(String path,
      {Map<dynamic, dynamic>? params,
      Map<String, String>? header,
      bool jsonDecoded = true}) async {
    AppComponentBase.instance.showProgressDialog();
    var finalHeader = {
      'Content-Type': 'application/json',
    };
    if (header != null) {
      finalHeader.addAll(header);
    }
    final response = await _client.get(
      Uri.parse(ApiConstants.baseUrl + path),
      headers: finalHeader,
    );
    AppComponentBase.instance.hideProgressDialog();
    if (response.statusCode == 200) {
      return jsonDecoded ? json.decode(response.body) : response.body;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  dynamic post(
    String path, {
    Map<String, String>? headers,
    Map<dynamic, dynamic>? params,
  }) async {
    var finalHeader = {
      'Content-Type': 'application/json',
    };
    if (headers != null) {
      finalHeader.addAll(headers);
    }
    final response = await _client.post(
      Uri.parse(ApiConstants.baseUrl + path),
      body: jsonEncode(params),
      // body: params,
      headers:
          finalHeader /*{
        'Content-Type': 'application/json',
      }*/
      ,
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else if (response.statusCode == 401) {
      throw UnauthorisedException();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  dynamic delete(
    String path, {
    Map<String, String>? headers,
    Map<dynamic, dynamic>? params,
  }) async {
    var finalHeader = {
      'Content-Type': 'application/json',
    };
    if (headers != null) {
      finalHeader.addAll(headers);
    }
    final response = await _client.delete(
      Uri.parse(ApiConstants.baseUrl + path),
      body: jsonEncode(params),
      // body: params,
      headers:
          finalHeader /*{
        'Content-Type': 'application/json',
      }*/
      ,
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else if (response.statusCode == 401) {
      throw UnauthorisedException();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
