import 'package:dartz/dartz.dart';
import 'package:ninjaz_posts_app/core/error/failure.dart';
import 'package:ninjaz_posts_app/core/usecase/base_usecase.dart';
import 'package:ninjaz_posts_app/core/usecase/no_paramas.dart';
import 'package:ninjaz_posts_app/features/posts/domain/repository/posts_base_repo.dart';

/// Clears all the offline posts from the repository
///
/// Calls the [PostsBaseRepo.clearPostsOffline] and returns a [void] or a [Failure]
class ClearOfflinePostsUsecase extends BaseUseCase<void, NoParams> {
  /// The repository that will handle the storage
  final PostsBaseRepo _postsBaseRepo;

  /// Creates a [ClearOfflinePostsUsecase]
  ///
  /// Takes a [PostsBaseRepo] as parameter
  ClearOfflinePostsUsecase(this._postsBaseRepo);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await _postsBaseRepo.clearPostsOffline();
  }
}
