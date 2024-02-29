import 'package:ninjaz_posts_app/features/posts/data/entities/post_entity.dart';
import 'package:ninjaz_posts_app/features/posts/domain/entities/owner.dart';
import 'package:ninjaz_posts_app/features/posts/domain/entities/post.dart';
import 'package:realm/realm.dart';

abstract class BasePostsLocalDatasource {
  Future<List<Post>> getPosts();
  Future<void> savePosts(List<Post> posts);
  Future<void> deletePosts();
}

class PostsLocalDatasource extends BasePostsLocalDatasource {
  final Realm _realm;

  PostsLocalDatasource(this._realm);

  @override
  Future<void> deletePosts() async {
    _realm.deleteAll<PostEntity>();
    _realm.deleteAll<OwnerEntity>();
  }

  @override
  Future<List<Post>> getPosts() async {
    final results = _realm.all<PostEntity>();
    return results
        .map((e) => Post(
              id: e.id,
              text: e.text,
              image: e.image,
              likes: e.likes,
              tags: e.tags,
              publishDate: e.publishDate,
              owner: Owner(
                id: e.owner?.id ?? '',
                title: e.owner?.title ?? '',
                firstName: e.owner?.firstName ?? '',
                lastName: e.owner?.lastName ?? '',
                picture: e.owner?.picture ?? '',
              ),
            ))
        .toList();
  }

  @override
  Future<void> savePosts(List<Post> posts) async {
    _realm.write(
      () {
        for (final post in posts) {
          final res = _realm.add(
            OwnerEntity(
              post.owner.id,
              post.owner.title,
              post.owner.firstName,
              post.owner.lastName,
              post.owner.picture,
            ),
            update: true,
          );
          _realm.add(
            PostEntity(
              post.id,
              post.text,
              post.image,
              post.likes,
              post.publishDate,
              owner: res,
              tags: post.tags,
            ),
            update: true,
          );
        }
      },
    );
  }
}
