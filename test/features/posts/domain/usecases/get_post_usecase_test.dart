import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ninjaz_posts_app/core/error/failure.dart';
import 'package:ninjaz_posts_app/features/posts/domain/entities/post.dart';
import 'package:ninjaz_posts_app/features/posts/domain/repository/posts_base_repo.dart';
import 'package:ninjaz_posts_app/features/posts/domain/usecases/get_post_usecase.dart';
import 'package:test/test.dart';

import 'posts_repo_mock.dart';

void main() {
  late PostsBaseRepo repo;
  late GetPostUsecase usecase;

  late Post post = Post.fromJson({
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

  /// Set up the usecase for each test
  setUp(() {
    repo = MockPostsRepo();
    usecase = GetPostUsecase(repo);
    registerFallbackValue(post);
  });

  /// Test that the usecase can get a single post
  ///
  /// 1. Mock the repo to return a post
  /// 2. Call the usecase with the post id
  /// 3. Expect the return value to be a [Right] with the post
  /// 4. Verify that the repo was called with the correct post id
  /// 5. Verify that the repo was called only once
  test('should get a single post', () async {
    // arrange
    when(() => repo.getPost(post.id)).thenAnswer(
      (_) async => Right(post),
    );

    // act
    final result = await usecase(post.id);

    // assert
    expect(result, Right<Failure, Post>(post));
    verify(() => repo.getPost(post.id));
    verifyNoMoreInteractions(repo);
  });

  /// Test that the usecase returns an error if an id doesn't exist
  ///
  /// 1. Mock the repo to return a [ServerFailure]
  /// 2. Call the usecase with a non existent post id
  /// 3. Expect the return value to be a [Left] with a [ServerFailure]
  /// 4. Verify that the repo was called with the correct post id
  /// 5. Verify that the repo was called only once
  test("should get an error if an id doesn't exist", () async {
    // arrange
    when(() => repo.getPost('123')).thenAnswer(
      (_) async => Left(
        ServerFailure(
          'Post not found',
        ),
      ),
    );

    // act
    final result = await usecase('123');

    // assert
    expect(result, Left<Failure, Post>(ServerFailure('Post not found')));
    verify(() => repo.getPost('123'));
    verifyNoMoreInteractions(repo);
  });
}
