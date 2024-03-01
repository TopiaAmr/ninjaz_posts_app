import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ninjaz_posts_app/core/network/api_consumer.dart';
import 'package:ninjaz_posts_app/core/network/dio_consumer.dart';
import 'package:ninjaz_posts_app/core/services/service_locator.dart';
import 'package:ninjaz_posts_app/features/posts/data/datasrouce/posts_remote_datasource.dart';
import 'package:ninjaz_posts_app/features/posts/domain/entities/post.dart';

import 'response_examples.dart';

/// A mock HTTP client for testing purposes.
class MockHTTPClient extends Mock implements DioConsumer {}

/// Unit tests for the [PostsRemoteDatasource].
void main() {
  /// The mock HTTP client.
  late ApiConsumer apiConsumer;

  /// The class under test.
  late BasePostsRemoteDatasource datasource;

  /// Set up the mock HTTP client and the class under test before each test.
  setUp(() {
    apiConsumer = MockHTTPClient();
    datasource = PostsRemoteDatasource(apiConsumer);
  });

  /// Initialize the service locator before all tests.
  setUpAll(() => ServiceLocator.init());

  /// Tests for the [getPosts] method.
  group('get posts', () {
    /// Tests that the method returns a list of posts.
    test('should return a list of posts', () async {
      // When the HTTP client is asked to get a list of posts,
      // return a response with the expected list of posts.
      when(() => apiConsumer.get(any())).thenAnswer(
        (_) async => Response<String>(
          data: listOfPosts,
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        ),
      );
      // Get the list of posts from the datasource.
      final response = await datasource.getPosts(1);
      // Verify that the response is a list of posts.
      expect(response, isA<List<Post>>());
    });

    /// Tests that the method returns an empty list of posts.
    test('should return an empty list of posts', () async {
      // When the HTTP client is asked to get a list of posts,
      // return a response with an empty list of posts.
      when(() => apiConsumer.get(any())).thenAnswer(
        (_) async => Response<String>(
          data: emptyResponse,
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        ),
      );
      // Get the list of posts from the datasource.
      final response = await datasource.getPosts(1);
      // Verify that the response is an empty list of posts.
      expect(response, isA<List<Post>>());
    });
  });

  /// Tests for the [getPost] method.
  group('get single post', () {
    /// Tests that the method returns a single post.
    test('should return a single post ', () async {
      // When the HTTP client is asked to get a single post,
      // return a response with the expected single post.
      when(() => apiConsumer.get(any())).thenAnswer(
        (_) async => Response<String>(
          data: singlePost,
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        ),
      );
      // Get the single post from the datasource.
      final response = await datasource.getPost('1');
      // Verify that the response is a single post.
      expect(response, isA<Post>());
    });

    /// Tests that the method returns an error when the post is not found.
    test('should return an error when the post is not found', () async {
      // When the HTTP client is asked to get a single post,
      // return a response with a 404 status code.
      when(() => apiConsumer.get(any())).thenAnswer(
        (_) async => Response<String>(
          data: errorResponse,
          statusCode: 404,
          requestOptions: RequestOptions(path: ''),
        ),
      );
      // Get the single post from the datasource.
      final response = datasource.getPost('1');
      // Verify that the response throws an error.
      expect(response, throwsException);
    });
  });
}
