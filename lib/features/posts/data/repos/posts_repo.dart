import 'package:dartz/dartz.dart';
import 'package:ninjaz_posts_app/core/error/exception.dart';
import 'package:ninjaz_posts_app/core/error/failure.dart';
import 'package:ninjaz_posts_app/features/posts/data/datasrouce/posts_local_datasource.dart';
import 'package:ninjaz_posts_app/features/posts/data/datasrouce/posts_remote_datasource.dart';
import 'package:ninjaz_posts_app/features/posts/domain/entities/post.dart';
import 'package:ninjaz_posts_app/features/posts/domain/repository/posts_base_repo.dart';

class PostsRepo extends PostsBaseRepo {
  final BasePostsRemoteDatasource _datasource;
  final BasePostsLocalDatasource _localDatasource;

  PostsRepo(this._datasource, this._localDatasource);

  @override
  Future<Either<Failure, Post>> getPost(String id) async {
    try {
      final post = await _datasource.getPost(id);
      return Right(post);
    } on ServerException catch (e) {
      return Left(
        ServerFailure(
          e.errorMessageModel.statusMessage,
        ),
      );
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Post>>> getPosts(int page) async {
    try {
      final posts = await _datasource.getPosts(page);
      return Right(posts);
    } on ServerException catch (e) {
      return Left(
        ServerFailure(
          e.errorMessageModel.statusMessage,
        ),
      );
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> clearPostsOffline() async {
    try {
      await _localDatasource.deletePosts();
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Post>>> getPostsOffline() async {
    try {
      final posts = await _localDatasource.getPosts();
      return Right(posts);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> savePostsOffline(List<Post> posts) async {
    try {
      await _localDatasource.savePosts(posts);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
