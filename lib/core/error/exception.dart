import 'package:ninjaz_posts_app/core/error/error_message_model.dart';

/// Represents a server-side error.
class ServerException implements Exception {
  /// Creates a new [ServerException] with the given [errorMessageModel].
  const ServerException(this.errorMessageModel);

  /// The [ErrorMessageModel] associated with the error.
  final ErrorMessageModel errorMessageModel;
}

/// Represents a bad request error.
class BackEndError extends ServerException {
  /// Creates a new [BackEndError] with the given [errorMessageModel].
  const BackEndError(super.errorMessageModel);
}

/// Represents a fetch data exception.
class FetchDataException extends ServerException {
  /// Creates a new [FetchDataException] with the given [errorMessageModel].
  ///
  /// If the [errorMessageModel] is `null`, a new [ErrorMessageModel] will be
  /// created with the [message].
  FetchDataException(ErrorMessageModel? errorMessageModel)
      : super(errorMessageModel ??
            const ErrorMessageModel(
              statusCode: 0,
              statusMessage: message,
              success: false,
            ));

  /// The error message associated with the exception.
  static const String message = 'Please check your internet connection';
}

/// Represents a bad request error.
class BadRequestException extends ServerException {
  /// Creates a new [BadRequestException] with the given [errorMessageModel].
  const BadRequestException(super.errorMessageModel);

  /// The error message associated with the exception.
  static const String message = "Couldn't process request";
}

/// Represents an unauthorized error.
class UnauthorizedException extends ServerException {
  /// Creates a new [UnauthorizedException] with the given [errorMessageModel].
  ///
  /// If the [errorMessageModel] is `null`, a new [ErrorMessageModel] will be
  /// created with the [message].
  UnauthorizedException(ErrorMessageModel? errorMessageModel)
      : super(errorMessageModel ??
            const ErrorMessageModel(
              statusCode: 0,
              statusMessage: message,
              success: false,
            ));

  /// The error message associated with the exception.
  static const String message = 'Session Expired';
}

/// Represents a not found error.
class NotFoundException extends ServerException {
  /// Creates a new [NotFoundException] with the given [errorMessageModel].
  const NotFoundException(super.errorMessageModel);

  /// The error message associated with the exception.
  static const String message = '';
}

/// Represents a conflict error.
class ConflictException extends ServerException {
  /// Creates a new [ConflictException] with the given [errorMessageModel].
  const ConflictException(super.errorMessageModel);

  /// The error message associated with the exception.
  static const String message = 'Session Expired';
}

/// Represents an internal server error.
class InternalServerErrorException extends ServerException {
  /// Creates a new [InternalServerErrorException] with the given [errorMessageModel].
  const InternalServerErrorException(super.errorMessageModel);

  /// The error message associated with the exception.
  static const String message = 'Session Expired';
}

/// Represents a no internet connection error.
class NoInternetConnectionException extends ServerException {
  /// Creates a new [NoInternetConnectionException] with the given [errorMessageModel].
  const NoInternetConnectionException(super.errorMessageModel);

  /// The error message associated with the exception.
  static const String message = 'Session Expired';
}

/// Represents a cache error.
class CacheException implements Exception {
  /// Creates a new [CacheException] with the given [message].
  const CacheException(this.message);

  /// The message associated with the exception.
  final String message;
}
