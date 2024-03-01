import 'package:dartz/dartz.dart';
import 'package:ninjaz_posts_app/core/error/failure.dart';
import 'package:ninjaz_posts_app/core/usecase/base_usecase.dart';
import 'package:ninjaz_posts_app/features/posts/domain/entities/post.dart';
import 'package:ninjaz_posts_app/features/posts/domain/repository/posts_base_repo.dart';

/// Gets a page of posts from the repository
///
/// Calls the [PostsBaseRepo.getPosts] and returns a [List] of [Post] or a [Failure]
class GetPostsUsecase extends BaseUseCase<List<Post>, int> {
  /// The repository that will handle the storage
  final PostsBaseRepo _postsBaseRepo;

  /// Creates a [GetPostsUsecase]
  ///
  /// Takes a [PostsBaseRepo] as parameter
  GetPostsUsecase(this._postsBaseRepo);

  @override
  Future<Either<Failure, List<Post>>> call(int page) async {
    return await _postsBaseRepo.getPosts(page);
  }
}
