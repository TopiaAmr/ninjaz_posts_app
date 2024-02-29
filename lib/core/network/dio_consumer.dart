import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:ninjaz_posts_app/core/error/error_message_model.dart';
import 'package:ninjaz_posts_app/core/error/exception.dart';
import 'package:ninjaz_posts_app/core/network/api_constants.dart';
import 'package:ninjaz_posts_app/core/network/api_consumer.dart';
import 'package:ninjaz_posts_app/core/network/status_codes.dart';
import 'package:ninjaz_posts_app/core/services/service_locator.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

/// A class that defines methods for making HTTP requests to an API
/// using the Dio library.
class DioConsumer implements ApiConsumer {
  /// The Dio instance.
  final Dio client;

  /// Creates an instance of [DioConsumer]
  /// with the given [client].
  DioConsumer({required this.client}) {
    client.options
      ..baseUrl = ApiConstants.baseUrl
      ..responseType = ResponseType.plain
      ..headers = {
        'app-id': ApiConstants.apiKey,
        Headers.contentTypeHeader: 'application/json;charset=UTF-8',
      }
      ..followRedirects = false
      ..validateStatus = (status) {
        return status! < StatusCode.internalServerError;
      };
    if (kDebugMode) {
      client.interceptors.add(getIt<PrettyDioLogger>());
    }
  }

  @override
  Future<Response<String>?> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic> data = const {},
  }) async {
    try {
      final Response<String> response = await client.get(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return response;
    } on DioException catch (error) {
      _handleDioError(error);
      return null;
    }
  }

  @override
  Future<Response<String>?> post(
    String path, {
    Map<String, dynamic> data = const {},
    bool formDataIsEnabled = false,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final Response<String> response = await client.post(
        path,
        queryParameters: queryParameters,
        data: formDataIsEnabled
            ? FormData.fromMap(data)
            : _handleRequestAsString(data),
      );
      return response;
    } on DioException catch (error) {
      _handleDioError(error);
      return null;
    }
  }

  @override
  Future<Response<String>?> put(
    String path, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final Response<String> response = await client.put(
        path,
        queryParameters: queryParameters,
        data: body,
      );
      return response;
    } on DioException catch (error) {
      _handleDioError(error);
      return null;
    }
  }

  dynamic _handleRequestAsString(Map<String, dynamic> data) {
    final requestJson = jsonEncode(data);
    return requestJson;
  }

  dynamic _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.sendTimeout:
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.unknown:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.badCertificate:
      case DioExceptionType.connectionError:
      case DioExceptionType.cancel:
        throw FetchDataException(
          ErrorMessageModel.fromDioError(
            error,
          ),
        );
      case DioExceptionType.badResponse:
        switch (error.response?.statusCode) {
          case StatusCode.badRequest:
            throw BadRequestException(ErrorMessageModel.fromDioError(error));
          case StatusCode.unauthorized:
          case StatusCode.forbidden:
            throw UnauthorizedException(
              ErrorMessageModel.fromDioError(
                error,
              ),
            );
          case StatusCode.notFound:
            throw NotFoundException(ErrorMessageModel.fromDioError(error));
          case StatusCode.confilct:
            throw ConflictException(ErrorMessageModel.fromDioError(error));
          case StatusCode.internalServerError:
            throw InternalServerErrorException(
              ErrorMessageModel.fromDioError(error),
            );
        }
    }
  }
}
