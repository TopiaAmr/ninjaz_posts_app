import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ninjaz_posts_app/core/usecase/no_paramas.dart';
import 'package:ninjaz_posts_app/features/posts/domain/entities/post.dart';
import 'package:ninjaz_posts_app/features/posts/domain/usecases/clear_offline_posts_usecase.dart';
import 'package:ninjaz_posts_app/features/posts/domain/usecases/get_post_usecase.dart';
import 'package:ninjaz_posts_app/features/posts/domain/usecases/get_posts_offline_usecase.dart';
import 'package:ninjaz_posts_app/features/posts/domain/usecases/get_posts_usecase.dart';
import 'package:ninjaz_posts_app/features/posts/domain/usecases/save_posts_offline_usecase.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetPostUsecase _getPostUsecase;
  final GetPostsUsecase _getPostsUsecase;
  final GetOfflinePostsUsecase _getOfflinePostsUsecase;
  final ClearOfflinePostsUsecase _clearOfflinePostsUsecase;
  final SaveOfflinePostsUsecase _saveOfflinePostsUsecase;

  PostsBloc(
    this._getPostUsecase,
    this._getPostsUsecase,
    this._getOfflinePostsUsecase,
    this._clearOfflinePostsUsecase,
    this._saveOfflinePostsUsecase,
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
    on<GetOfflinePostsEvent>(_getOfflinePosts);
    on<ClearOfflinePostsEvent>(_clearOfflinePosts);
    on<SaveOfflinePostsEvent>(_saveOfflinePosts);
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

  FutureOr<void> _getOfflinePosts(
    GetOfflinePostsEvent event,
    Emitter<PostsState> emit,
  ) async {
    emit(state.copyWith(status: PostsStatus.loading));
    final res = await _getOfflinePostsUsecase.call(NoParams());
    res.fold((failure) {
      emit(state.copyWith(
        status: PostsStatus.failure,
        error: failure.message,
      ));
    }, (posts) {
      emit(state.copyWith(
        status: PostsStatus.success,
        currentPostDetails: null,
        error: '',
        posts: posts,
      ));
    });
  }

  FutureOr<void> _clearOfflinePosts(
    ClearOfflinePostsEvent event,
    Emitter<PostsState> emit,
  ) async {
    final res = await _clearOfflinePostsUsecase.call(NoParams());
    res.fold(
      (failure) {},
      (posts) {},
    );
  }

  FutureOr<void> _saveOfflinePosts(
    SaveOfflinePostsEvent event,
    Emitter<PostsState> emit,
  ) async {
    final res = await _saveOfflinePostsUsecase.call(event.posts);
    res.fold(
      (failure) {},
      (posts) {},
    );
  }
}
