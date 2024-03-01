part of 'posts_bloc.dart';

/// The status of the posts feature.
///
/// This is used to represent the current state of the posts feature.
/// The possible values are:
/// - [PostsStatus.initial] - the initial state before any data has been fetched.
/// - [PostsStatus.loading] - the state when data is being fetched.
/// - [PostsStatus.success] - the state when data has been fetched successfully.
/// - [PostsStatus.failure] - the state when there has been an error fetching data.
enum PostsStatus { initial, loading, success, failure }

/// The state of the posts feature.
///
/// This is used to represent the current state of the posts feature.
/// It contains the following properties:
/// - [status] - the current [PostsStatus] of the feature.
/// - [posts] - the list of posts.
/// - [error] - the error message if there is an error.
/// - [currentPostDetails] - the details of the currently selected post.
/// - [page] - the current page of posts being shown.
/// - [isOffline] - whether or not the posts are being shown from offline storage.
class PostsState extends Equatable {
  /// The current [PostsStatus] of the feature.
  final PostsStatus status;

  /// The list of posts.
  final List<Post> posts;

  /// The error message if there is an error.
  final String error;

  /// The details of the currently selected post.
  final Post? currentPostDetails;

  /// The current page of posts being shown.
  final int page;

  /// Whether or not the posts are being shown from offline storage.
  final bool isOffline;

  /// Creates a [PostsState].
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

  /// Copies the [PostsState] with the given parameters overridden.
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
