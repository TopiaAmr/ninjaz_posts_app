import 'package:dio/dio.dart';

/// This abstract class defines methods for making HTTP requests to an API.
abstract class ApiConsumer {
  /// Sends a GET request to the specified [path] with optional [queryParameters].
  ///
  /// Returns a `Future` that completes with the response body.
  Future<Response<String>?> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic> data = const {},
  });

  /// Sends a POST request to the specified [path] with optional [data] and [queryParameters].
  ///
  /// Returns a `Future` that completes with the response body.
  Future<Response<String>?> post(
    String path, {
    Map<String, dynamic> data = const {},
    Map<String, dynamic>? queryParameters,
  });

  /// Sends a PUT request to the specified [path] with optional [body] and [queryParameters].
  ///
  /// Returns a `Future` that completes with the response body.
  Future<Response<String>?> put(
    String path, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
  });
}
