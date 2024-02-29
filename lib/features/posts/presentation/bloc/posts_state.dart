part of 'posts_bloc.dart';

enum PostsStatus { initial, loading, success, failure }

class PostsState extends Equatable {
  final PostsStatus status;
  final List<Post> posts;
  final String error;

  const PostsState({
    required this.status,
    required this.posts,
    required this.error,
  });

  @override
  List<Object> get props => [status, posts, error];

  PostsState copyWith({
    PostsStatus? status,
    List<Post>? posts,
    String? error,
  }) {
    return PostsState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
      error: error ?? this.error,
    );
  }
}
