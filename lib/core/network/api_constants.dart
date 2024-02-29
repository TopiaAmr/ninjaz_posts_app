class ApiConstants {
  ApiConstants._();

  static const String baseUrl = 'https://dummyapi.io';
  static const String apiKey = '65e080d27fecd42961c1131e';

  static String posts(int page) => '/data/v1/posts?limit=10&page=$page';
  static const String post = '/data/v1/posts';
}
