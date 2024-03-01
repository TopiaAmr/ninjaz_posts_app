import 'package:dartz/dartz.dart';
import 'package:ninjaz_posts_app/core/error/failure.dart';
import 'package:ninjaz_posts_app/core/usecase/base_usecase.dart';
import 'package:ninjaz_posts_app/features/posts/domain/entities/post.dart';
import 'package:ninjaz_posts_app/features/posts/domain/repository/posts_base_repo.dart';

/// Saves a page of [Post] offline
///
/// Calls the [PostsBaseRepo.savePostsOffline] and returns a [void] or a [Failure]
class SaveOfflinePostsUsecase extends BaseUseCase<void, List<Post>> {
  final PostsBaseRepo _postsBaseRepo;

  /// Creates a [SaveOfflinePostsUsecase]
  ///
  /// Takes a [PostsBaseRepo] as parameter
  SaveOfflinePostsUsecase(this._postsBaseRepo);

  @override
  Future<Either<Failure, void>> call(List<Post> posts) async {
    return await _postsBaseRepo.savePostsOffline(posts);
  }
}
