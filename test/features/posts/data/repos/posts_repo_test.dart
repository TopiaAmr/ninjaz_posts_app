import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ninjaz_posts_app/core/error/failure.dart';
import 'package:ninjaz_posts_app/features/posts/data/datasrouce/posts_remote_datasource.dart';
import 'package:ninjaz_posts_app/features/posts/data/repos/posts_repo.dart';
import 'package:ninjaz_posts_app/features/posts/domain/entities/post.dart';
import 'package:ninjaz_posts_app/features/posts/domain/repository/posts_base_repo.dart';
import 'package:test/test.dart';

import 'posts_remotesource_mock.dart';

void main() {
  late PostsBaseRepo repo;
  late BasePostsRemoteDatasource datasource;

  const fakeError = ServerFailure(
    'error',
  );

  Post fakePost = Post.fromJson({
    "id": "60d21aed67d0d8992e610b7f",
    "image": "https://img.dummyapi.io/photo-1582490738676-9ea599096c68.jpg",
    "likes": 13,
    "link": "https://www.discover194.com/",
    "tags": ["animal", "dog", "canine"],
    "text": "Dog giving a high five white and black long coat small dog",
    "publishDate": "2019-11-07T16:42:30.296Z",
    "owner": {
      "id": "60d0fe4f5311236168a109ff",
      "title": "mrs",
      "firstName": "Josefina",
      "lastName": "Calvo",
      "picture": "https://randomuser.me/api/portraits/med/women/3.jpg"
    }
  });

  setUp(() {
    datasource = PostsRemoteDatasourceMock();
    repo = PostsRepo(datasource);
    registerFallbackValue(fakePost);
  });

  group('get post', () {
    test('should get a post from the repo', () async {
      when(() => datasource.getPost('1')).thenAnswer(
        (_) => Future.value(
          fakePost.copyWith(id: '1'),
        ),
      );
      final result = await repo.getPost('1');
      expect(result, isA<Right<Failure, Post>>());
      verify(() => datasource.getPost('1'));
      verifyNoMoreInteractions(datasource);
    });

    test('should return a server failure', () async {
      when(() => datasource.getPost('1')).thenThrow(fakeError);
      final result = await repo.getPost('1');
      expect(result, isA<Left<Failure, Post>>());
      verify(() => datasource.getPost('1'));
      verifyNoMoreInteractions(datasource);
    });
  });

  group('get posts', () {
    test('should return a list of posts', () async {
      when(() => datasource.getPosts(0)).thenAnswer(
        (_) => Future.value(
          <Post>[
            fakePost.copyWith(id: '1'),
          ],
        ),
      );
      final result = await repo.getPosts(0);
      expect(result, isA<Right<Failure, List<Post>>>());
      verify(() => datasource.getPosts(0));
      verifyNoMoreInteractions(datasource);
    });
  });
}
