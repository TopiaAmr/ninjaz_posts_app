part of 'posts_bloc.dart';

enum PostsStatus { initial, loading, success, failure }

class PostsState extends Equatable {
  final PostsStatus status;
  final List<Post> posts;
  final Post? currentPostDetails;
  final String error;
  final int page;
  final bool isOffline;

  const PostsState({
    required this.status,
    required this.posts,
    required this.error,
    required this.currentPostDetails,
    this.page = 0,
    this.isOffline = false,
  });

  @override
  List<Object?> get props => [status, posts, error, currentPostDetails, page];

  PostsState copyWith({
    PostsStatus? status,
    List<Post>? posts,
    String? error,
    Post? currentPostDetails,
    int? page,
    bool? isOffline,
  }) {
    return PostsState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
      error: error ?? this.error,
      currentPostDetails: currentPostDetails ?? this.currentPostDetails,
      page: page ?? this.page,
      isOffline: isOffline ?? this.isOffline,
    );
  }
}
