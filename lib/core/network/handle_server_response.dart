import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ninjaz_posts_app/core/error/error_message_model.dart';
import 'package:ninjaz_posts_app/core/error/exception.dart';

///
class HandleServerResponse {
  /// A function that handles the response from the server.
  /// It returns the  data or throws an exception.
  static Map<String, dynamic> call(Response<String> result) {
    final Map<String, dynamic> jsonresult = _handleResponseAsJson(result);
    if (jsonresult.containsKey('error')) {
      throw BackEndError(
        ErrorMessageModel(
          statusCode: 0,
          statusMessage: jsonresult['error'].toString(),
          success: false,
        ),
      );
    }
    return jsonresult;
  }

  static Map<String, dynamic> _handleResponseAsJson(Response<String> response) {
    final Map<String, dynamic> responseJson =
        jsonDecode(response.data ?? '') as Map<String, dynamic>;
    return responseJson;
  }
}
