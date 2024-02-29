import 'package:dio/dio.dart';
import 'package:ninjaz_posts_app/core/network/api_constants.dart';
import 'package:ninjaz_posts_app/core/network/api_consumer.dart';
import 'package:ninjaz_posts_app/core/network/handle_server_response.dart';
import 'package:ninjaz_posts_app/features/posts/domain/entities/post.dart';

abstract class BasePostsRemoteDatasource {
  Future<List<Post>> getPosts(int page);
  Future<Post> getPost(String id);
}

class PostsRemoteDatasource extends BasePostsRemoteDatasource {
  final ApiConsumer _apiConsumer;

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
