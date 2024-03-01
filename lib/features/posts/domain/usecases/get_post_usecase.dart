import 'package:dartz/dartz.dart';
import 'package:ninjaz_posts_app/core/error/failure.dart';
import 'package:ninjaz_posts_app/core/usecase/base_usecase.dart';
import 'package:ninjaz_posts_app/features/posts/domain/entities/post.dart';
import 'package:ninjaz_posts_app/features/posts/domain/repository/posts_base_repo.dart';

/// Gets a single post by its [id]
///
/// Calls the [PostsBaseRepo.getPost] and returns a [Post] or a [Failure]
class GetPostUsecase extends BaseUseCase<Post, String> {
  /// The repository that will handle the storage
  final PostsBaseRepo _postsBaseRepo;

  /// Creates a [GetPostUsecase]
  ///
  /// Takes a [PostsBaseRepo] as parameter
  GetPostUsecase(this._postsBaseRepo);

  @override
  Future<Either<Failure, Post>> call(String id) async {
    return await _postsBaseRepo.getPost(id);
  }
}
