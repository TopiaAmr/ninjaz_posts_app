import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

/// A model representing the error message returned from the server.
///
/// This model is returned as part of the [ServerException] when a server error
/// occurs. It contains information about the error that occurred, including
/// the HTTP status code, the error message, and a flag indicating whether
/// the request was successful or not.
class ErrorMessageModel extends Equatable {
  /// Creates a new [ErrorMessageModel] with the given parameters.
  ///
  /// The [statusCode] and [statusMessage] parameters must not be null.
  const ErrorMessageModel({
    required this.statusCode,
    required this.statusMessage,
    required this.success,
  });

  /// Creates a new [ErrorMessageModel] from the given [Map].
  ///
  /// The [map] parameter must not be null.
  factory ErrorMessageModel.fromMap(Map<String, dynamic> map) {
    return ErrorMessageModel(
      statusCode: map['code'] as int,
      statusMessage: map['message'] as String,
      success: map['success'] == true,
    );
  }

  /// Creates a new [ErrorMessageModel] from the given [DioException].
  ///
  /// The [error] parameter must not be null.
  factory ErrorMessageModel.fromDioError(DioException error) {
    return ErrorMessageModel(
      statusCode: error.response?.statusCode ?? 0,
      statusMessage: error.error.toString(),
      success: false,
    );
  }

  /// The HTTP status code associated with the error.
  final int statusCode;

  /// The error message associated with the error.
  final String statusMessage;

  /// A flag indicating whether the request was successful or not.
  final bool success;

  @override
  List<Object> get props => [statusCode, statusMessage, success];

  /// Converts this [ErrorMessageModel] to a [Map].
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'code': statusCode,
      'message': statusMessage,
      'success': success,
    };
  }

  /// Converts this [ErrorMessageModel] to a JSON [String].
  String toJson() => json.encode(toMap());

  /// Creates a copy of this [ErrorMessageModel] with the given fields replaced
  /// by the new values.
  ///
  /// The new values must not be null.
  ErrorMessageModel copyWith({
    int? statusCode,
    String? statusMessage,
    bool? success,
  }) {
    return ErrorMessageModel(
      statusCode: statusCode ?? this.statusCode,
      statusMessage: statusMessage ?? this.statusMessage,
      success: success ?? this.success,
    );
  }
}
