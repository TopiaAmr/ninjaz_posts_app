import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ninjaz_posts_app/core/network/api_consumer.dart';
import 'package:ninjaz_posts_app/core/network/dio_consumer.dart';
import 'package:ninjaz_posts_app/core/services/service_locator.dart';
import 'package:ninjaz_posts_app/features/posts/data/datasrouce/posts_remote_datasource.dart';
import 'package:ninjaz_posts_app/features/posts/domain/entities/post.dart';

import 'response_examples.dart';

class MockHTTPClient extends Mock implements DioConsumer {}

void main() {
  late ApiConsumer apiConsumer;
  late BasePostsRemoteDatasource datasource;

  setUp(() {
    apiConsumer = MockHTTPClient();
    datasource = PostsRemoteDatasource(apiConsumer);
  });

  setUpAll(() => ServiceLocator.init());

  group('get posts', () {
    test('should return a list of posts', () async {
      when(() => apiConsumer.get(any())).thenAnswer(
        (_) async => Response<String>(
          data: listOfPosts,
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        ),
      );
      final response = await datasource.getPosts(1);
      expect(response, isA<List<Post>>());
    });

    test('should return an empty list of posts', () async {
      when(() => apiConsumer.get(any())).thenAnswer(
        (_) async => Response<String>(
          data: emptyResponse,
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        ),
      );
      final response = await datasource.getPosts(1);
      expect(response, isA<List<Post>>());
    });
  });

  group('get single post', () {
    test('should return a single post ', () async {
      when(() => apiConsumer.get(any())).thenAnswer(
        (_) async => Response<String>(
          data: singlePost,
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        ),
      );
      final response = await datasource.getPost('1');
      expect(response, isA<Post>());
    });

    test('should return an error when the post is not found', () async {
      when(() => apiConsumer.get(any())).thenAnswer(
        (_) async => Response<String>(
          data: errorResponse,
          statusCode: 404,
          requestOptions: RequestOptions(path: ''),
        ),
      );
      final response = datasource.getPost('1');
      expect(response, throwsException);
    });
  });
}
