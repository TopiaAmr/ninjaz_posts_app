import 'package:dio/dio.dart';
import 'package:ninjaz_posts_app/core/network/api_constants.dart';
import 'package:ninjaz_posts_app/core/network/api_consumer.dart';
import 'package:ninjaz_posts_app/core/network/handle_server_response.dart';
import 'package:ninjaz_posts_app/features/posts/domain/entities/post.dart';

/// An abstract class for a Posts remote data source.
///
/// This class should be extended by a concrete implementation, providing
/// a way to get Posts data from an API endpoint.
abstract class BasePostsRemoteDatasource {
  /// Gets a list of [Post]s from a remote data source.
  ///
  /// [page] is the page of the data to get.
  ///
  /// Returns a [Future] containing a [List<Post>] with the data returned
  /// from the API.
  Future<List<Post>> getPosts(int page);

  /// Gets a [Post] by its [id] from a remote data source.
  ///
  /// [id] is the id of the [Post] to get.
  ///
  /// Returns a [Future] containing a [Post] with the data returned
  /// from the API.
  Future<Post> getPost(String id);
}

/// A concrete implementation of [BasePostsRemoteDatasource]
/// that gets Posts data from an API endpoint.
class PostsRemoteDatasource extends BasePostsRemoteDatasource {
  /// The [ApiConsumer] to use to make the HTTP requests.
  final ApiConsumer _apiConsumer;

  /// Creates a [PostsRemoteDatasource] with the given [apiConsumer].
  PostsRemoteDatasource(this._apiConsumer);

  @override
  Future<List<Post>> getPosts(int page) async {
    final Response<String>? response =
        await _apiConsumer.get(ApiConstants.posts(page));
    final data = await HandleServerResponse.call(response!);
    return (data['data'] as List)
        .map((e) => Post.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<Post> getPost(String id) async {
    final response = await _apiConsumer.get('${ApiConstants.post}/$id');
    final data = await HandleServerResponse.call(response!);
    return Post.fromJson(data);
  }
}
