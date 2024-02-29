import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ninjaz_posts_app/features/posts/domain/entities/post.dart';
import 'package:ninjaz_posts_app/features/posts/domain/repository/posts_base_repo.dart';
import 'package:ninjaz_posts_app/features/posts/domain/usecases/get_posts_usecase.dart';
import 'package:test/test.dart';

import 'posts_repo_mock.dart';

void main() {
  late PostsBaseRepo repo;
  late GetPostsUsecase usecase;

  setUp(() {
    repo = MockPostsRepo();
    usecase = GetPostsUsecase(repo);
  });

  ///
  /// Test that the usecase can get a list of posts from the repo
  ///
  /// 1. Mock the repo to return a list of posts
  /// 2. Call the usecase with no parameters
  /// 3. Expect the return value to be a [Right] with an empty list of posts
  /// 4. Verify that the repo was called with no parameters
  /// 5. Verify that the repo was called only once
  test('should get list of posts from the repo', () async {
    // arrange
    when(() => repo.getPosts(0)).thenAnswer((_) async => const Right(<Post>[]));

    // act
    final result = await usecase(0);

    // assert
    expect(result, const Right<dynamic, List<Post>>(<Post>[]));
    verify(() => repo.getPosts(0));
    verifyNoMoreInteractions(repo);
  });
}
