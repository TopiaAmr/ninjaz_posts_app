/// This class defines constants representing common HTTP status codes.
class StatusCode {
  /// Represents the HTTP status code for a successful request (200 OK).
  static const int ok = 200;

  /// Represents the HTTP status code for a malformed or invalid request (400 Bad Request).
  static const int badRequest = 400;

  /// Represents the HTTP status code for a request that requires authentication (401 Unauthorized).
  static const int unauthorized = 401;

  /// Represents the HTTP status code for a request that is forbidden (403 Forbidden).
  static const int forbidden = 403;

  /// Represents the HTTP status code for a request that could not be found (404 Not Found).
  static const int notFound = 404;

  /// Represents the HTTP status code for a request that conflicts with an existing resource (409 Conflict).
  static const int confilct = 409;

  /// Represents the HTTP status code for a server error (500 Internal Server Error).
  static const int internalServerError = 500;
}
