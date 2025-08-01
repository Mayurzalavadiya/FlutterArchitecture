import 'dart:convert';

import 'package:dio/dio.dart';

import '../../db/app_db.dart';

class CustomInterceptors extends Interceptor {
  @override
  Future onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) async {
    options.headers['content-type'] = 'text/plain';
    options.headers['contentType'] = 'text/plain';
    options.headers['responseType'] = 'text/plain';
    options.responseType = ResponseType.plain;

    // options.headers.putIfAbsent("api-key", () => appDB.apiKey);
    // if (appDB.token.isNotEmpty) {
    //   options.headers['token'] = (appDB.token);
    // }
    // if (options.data != null) {
    //   options.data =(jsonEncode(options.data));
    // }

    return handler.next(options);
  }

  @override
  Future onResponse(
      Response response,
      ResponseInterceptorHandler handler,
      ) async {
    // final enc = locator.get<EncService>();
    response.data = jsonDecode(response.data.toString());
    return handler.next(response);
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    return handler.next(err);
  }
}
