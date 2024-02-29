import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:ninjaz_posts_app/core/services/service_locator.dart';
import 'package:ninjaz_posts_app/core/usecase/no_paramas.dart';
import 'package:ninjaz_posts_app/features/posts/domain/entities/post.dart';
import 'package:ninjaz_posts_app/features/posts/domain/usecases/clear_offline_posts_usecase.dart';
import 'package:ninjaz_posts_app/features/posts/domain/usecases/get_post_usecase.dart';
import 'package:ninjaz_posts_app/features/posts/domain/usecases/get_posts_offline_usecase.dart';
import 'package:ninjaz_posts_app/features/posts/domain/usecases/get_posts_usecase.dart';
import 'package:ninjaz_posts_app/features/posts/domain/usecases/save_posts_offline_usecase.dart';

part 'posts_event.dart';
part 'posts_state.dart';

/// The bloc responsible for handling posts related events
///
/// This bloc is responsible for handling events related to posts.
/// It is also responsible for updating the UI based on the posts data
/// retrieved from the API or from the offline storage
class PostsBloc extends Bloc<PostsEvent, PostsState> {
  /// UseCase to get a single post by id
  final GetPostUsecase _getPostUsecase;

  /// UseCase to get a list of all posts
  final GetPostsUsecase _getPostsUsecase;

  /// UseCase to get a list of offline posts
  final GetOfflinePostsUsecase _getOfflinePostsUsecase;

  /// UseCase to clear the offline posts
  final ClearOfflinePostsUsecase _clearOfflinePostsUsecase;

  /// UseCase to save the posts to offline storage
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

  /// Get post
  ///
  /// Calls the [GetPostUsecase] and emits the current state with the retrieved
  /// post if successful. Otherwise, it emits the current state with
  /// `status` property set to [PostsStatus.failure] and `error` property set
  /// to the error message
  ///
  /// {@macro usecases.getPost}
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

  /// Get posts
  ///
  /// If there is no internet access, it will check if there are offline posts
  /// and emit the current state with `isOffline` property set to `true` if
  /// successful. Otherwise, it will call the [GetPostsUsecase] and emit the
  /// current state with `isOffline` property set to `false` if successful
  ///
  /// {@macro usecases.getPosts}
  FutureOr<void> _getPosts(
    GetPostsEvent event,
    Emitter<PostsState> emit,
  ) async {
    if (!await getIt<InternetConnection>().hasInternetAccess) {
      if (state.posts.isEmpty) {
        add(GetOfflinePostsEvent());
      }
      return;
    }
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
        add(SaveOfflinePostsEvent(posts));
        emit(
          state.copyWith(
            status: PostsStatus.success,
            currentPostDetails: null,
            error: '',
            posts: event.page == 0 ? posts : [...state.posts, ...posts],
            isOffline: false,
          ),
        );
      },
    );
  }

  /// Get offline posts
  ///
  /// Calls the [GetOfflinePostsUsecase] and emits the current state with
  /// `isOffline` property set to `true` if successful
  ///
  /// {@macro usecases.getOfflinePosts}
  FutureOr<void> _getOfflinePosts(
    GetOfflinePostsEvent event,
    Emitter<PostsState> emit,
  ) async {
    emit(state.copyWith(status: PostsStatus.loading));
    final res = await _getOfflinePostsUsecase.call(NoParams());
    res.fold(
      (failure) {
        emit(state.copyWith(
          status: PostsStatus.failure,
          error: failure.message,
        ));
      },
      (posts) {
        emit(
          state.copyWith(
            status: PostsStatus.success,
            currentPostDetails: null,
            error: '',
            posts: posts,
            isOffline: true,
          ),
        );
      },
    );
  }

  /// Clear offline posts
  ///
  /// Calls the [ClearOfflinePostsUsecase] and emits the current state with
  /// `isOffline` property set to `false` if successful
  ///
  /// {@macro usecases.clearOfflinePosts}
  FutureOr<void> _clearOfflinePosts(
    ClearOfflinePostsEvent event,
    Emitter<PostsState> emit,
  ) async {
    final res = await _clearOfflinePostsUsecase.call(NoParams());
    res.fold(
      (failure) {},
      (posts) {
        emit(state.copyWith(isOffline: false));
      },
    );
  }

  /// Save offline posts
  ///
  /// Calls the [SaveOfflinePostsUsecase] and does not emit anything
  ///
  /// {@macro usecases.saveOfflinePosts}
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
