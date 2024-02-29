import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ninjaz_posts_app/features/posts/domain/entities/post.dart';
import 'package:ninjaz_posts_app/features/posts/domain/usecases/get_post_usecase.dart';
import 'package:ninjaz_posts_app/features/posts/domain/usecases/get_posts_usecase.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetPostUsecase _getPostUsecase;
  final GetPostsUsecase _getPostsUsecase;

  PostsBloc(
    this._getPostUsecase,
    this._getPostsUsecase,
  ) : super(
          const PostsState(
            status: PostsStatus.initial,
            posts: [],
            error: '',
            currentPostDetails: null,
          ),
        ) {
    on<GetPostEvent>(_getPost);
    on<GetPostsEvent>(_getPosts);
  }

  FutureOr<void> _getPost(
    GetPostEvent event,
    Emitter<PostsState> emit,
  ) async {
    final post = await _getPostUsecase(event.id);
    post.fold(
      (failure) {
        emit(
          state.copyWith(
            status: PostsStatus.failure,
            error: failure.message,
            currentPostDetails: null,
          ),
        );
      },
      (post) {
        emit(
          state.copyWith(
            status: PostsStatus.success,
            currentPostDetails: post,
            error: '',
          ),
        );
      },
    );
  }

  FutureOr<void> _getPosts(
    GetPostsEvent event,
    Emitter<PostsState> emit,
  ) async {
    emit(state.copyWith(status: PostsStatus.loading));
    final res = await _getPostsUsecase(event.page);
    res.fold(
      (failure) {
        emit(
          state.copyWith(
            status: PostsStatus.failure,
            error: failure.message,
            currentPostDetails: null,
            posts: [],
          ),
        );
      },
      (posts) {
        emit(
          state.copyWith(
            status: PostsStatus.success,
            currentPostDetails: null,
            error: '',
            posts: [...state.posts, ...posts],
          ),
        );
      },
    );
  }
}
