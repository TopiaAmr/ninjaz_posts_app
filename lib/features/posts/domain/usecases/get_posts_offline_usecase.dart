import 'package:dartz/dartz.dart';
import 'package:ninjaz_posts_app/core/error/failure.dart';
import 'package:ninjaz_posts_app/core/usecase/base_usecase.dart';
import 'package:ninjaz_posts_app/core/usecase/no_paramas.dart';
import 'package:ninjaz_posts_app/features/posts/domain/entities/post.dart';
import 'package:ninjaz_posts_app/features/posts/domain/repository/posts_base_repo.dart';

/// Gets all the offline posts from the repository
///
/// Calls the [PostsBaseRepo.getPostsOffline] and returns a [List] of [Post] or a [Failure]
class GetOfflinePostsUsecase extends BaseUseCase<List<Post>, NoParams> {
  /// The repository that will handle the storage
  final PostsBaseRepo _postsBaseRepo;

  /// Creates a [GetOfflinePostsUsecase]
  ///
  /// Takes a [PostsBaseRepo] as parameter
  GetOfflinePostsUsecase(this._postsBaseRepo);

  @override
  Future<Either<Failure, List<Post>>> call(NoParams params) async {
    return await _postsBaseRepo.getPostsOffline();
  }
}
