import 'package:dartz/dartz.dart';
import 'package:ninjaz_posts_app/core/error/failure.dart';
import 'package:ninjaz_posts_app/core/usecase/base_usecase.dart';
import 'package:ninjaz_posts_app/features/posts/domain/entities/post.dart';
import 'package:ninjaz_posts_app/features/posts/domain/repository/posts_base_repo.dart';

class GetPostsUsecase extends BaseUseCase<List<Post>, int> {
  final PostsBaseRepo _postsBaseRepo;

  GetPostsUsecase(this._postsBaseRepo);

  @override
  Future<Either<Failure, List<Post>>> call(int page) async {
    return await _postsBaseRepo.getPosts(page);
  }
}
