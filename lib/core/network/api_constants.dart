/// Contains the base URL and API key for making requests to the DummyAPI.io API.
class ApiConstants {
  /// Private constructor to prevent instantiation.
  ApiConstants._();

  /// The base URL for all API requests.
  ///
  /// Currently set to 'https://dummyapi.io'.
  static const String baseUrl = 'https://dummyapi.io';

  /// The API key for authenticating API requests.
  ///
  /// Currently set to '65e080d27fecd42961c1131e'.
  static const String apiKey = '65e080d27fecd42961c1131e';

  /// Returns a URL for retrieving a list of posts.
  ///
  /// The [page] parameter specifies which page of results to retrieve.
  static String posts(int page) => '$baseUrl/data/v1/post?limit=20&page=$page';

  /// The URL for retrieving a single post.
  ///
  /// The ID of the post is a path parameter.
  static const String post = '$baseUrl/data/v1/post/{id}';
}
