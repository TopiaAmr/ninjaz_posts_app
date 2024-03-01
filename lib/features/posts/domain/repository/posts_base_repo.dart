import 'package:dartz/dartz.dart';
import 'package:ninjaz_posts_app/core/error/failure.dart';
import 'package:ninjaz_posts_app/features/posts/domain/entities/post.dart';

/// Repository for managing [Post] entities

/// Repository for managing [Post] entities
abstract class PostsBaseRepo {
  /// Gets all available [Post] entities
  ///
  /// Retrieves all the [Post] entities from the data source.
  ///
  /// Returns a [Right] containing a [List] of [Post] entities if
  /// successful, or a [Left] containing a [Failure] if there is
  /// an error.
  Future<Either<Failure, List<Post>>> getPosts(int page);

  /// Gets a single [Post] entity by its [id]
  ///
  /// Retrieves a single [Post] entity from the data source.
  ///
  /// Returns a [Right] containing the [Post] entity if successful,
  /// or a [Left] containing a [Failure] if there is an error.
  Future<Either<Failure, Post>> getPost(String id);

  /// Saves a list of [Post] entities offline
  ///
  /// Saves a list of [Post] entities to the data source.
  ///
  /// Returns a [Right] containing `null` if successful,
  /// or a [Left] containing a [Failure] if there is an error.
  Future<Either<Failure, void>> savePostsOffline(List<Post> posts);

  /// Clears all offline posts
  ///
  /// Deletes all the offline [Post] entities from the data source.
  ///
  /// Returns a [Right] containing `null` if successful,
  /// or a [Left] containing a [Failure] if there is an error.
  Future<Either<Failure, void>> clearPostsOffline();

  /// Gets all offline posts
  ///
  /// Retrieves all the offline [Post] entities from the data source.
  ///
  /// Returns a [Right] containing a [List] of [Post] entities if
  /// successful, or a [Left] containing a [Failure] if there is
  /// an error.
  Future<Either<Failure, List<Post>>> getPostsOffline();
}
