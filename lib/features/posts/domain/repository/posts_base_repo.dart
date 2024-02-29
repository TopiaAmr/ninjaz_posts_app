import 'package:dartz/dartz.dart';
import 'package:ninjaz_posts_app/core/error/failure.dart';
import 'package:ninjaz_posts_app/features/posts/domain/entities/post.dart';

/// Repository for managing [Post] entities
abstract class PostsBaseRepo {
  /// Gets all available [Post] entities
  Future<Either<Failure, List<Post>>> getPosts(int paga);

  /// Gets a single [Post] entity by its [id]
  Future<Either<Failure, Post>> getPost(String id);
}
