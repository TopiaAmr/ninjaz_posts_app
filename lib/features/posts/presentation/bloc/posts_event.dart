part of 'posts_bloc.dart';

/// The base event for the [PostsBloc].
///
/// This event is extended by other events in the [PostsBloc] to provide
/// specific functionality for each type of event.
abstract class PostsEvent extends Equatable {
  /// The props for the event.
  ///
  /// This is used by the [Equatable] package to determine whether two instances
  /// of the event are equal.
  @override
  List<Object> get props => [];
}

/// An event to get a list of posts from the server.
///
/// This event is used to request a list of posts from the server when the user is
/// online. The [page] field specifies which page of posts to request.
class GetPostsEvent extends PostsEvent {
  /// The page of posts to request from the server.
  final int page;

  /// Creates a [GetPostsEvent] instance.
  ///
  /// The [page] argument specifies which page of posts to request from the
  /// server.
  GetPostsEvent(this.page);

  @override
  List<Object> get props => [page];
}

/// An event to get a single post from the server.
///
/// This event is used to request a single post from the server when the user is
/// online. The [id] field specifies which post to request.
class GetPostEvent extends PostsEvent {
  /// The id of the post to request from the server.
  final String id;

  /// Creates a [GetPostEvent] instance.
  ///
  /// The [id] argument specifies which post to request from the server.
  GetPostEvent(this.id);

  @override
  List<Object> get props => [id];
}

/// An event to get a list of offline posts.
///
/// This event is used to request a list of posts from the local database when
/// the user is offline.
class GetOfflinePostsEvent extends PostsEvent {
  /// Creates a [GetOfflinePostsEvent] instance.
  GetOfflinePostsEvent();

  @override
  List<Object> get props => [];
}

/// An event to clear the list of offline posts.
///
/// This event is used to clear the list of offline posts from the local database.
class ClearOfflinePostsEvent extends PostsEvent {
  /// Creates a [ClearOfflinePostsEvent] instance.
  ClearOfflinePostsEvent();

  @override
  List<Object> get props => [];
}

/// An event to save a list of posts to the local database.
///
/// This event is used to save a list of posts to the local database when the user
/// is online.
class SaveOfflinePostsEvent extends PostsEvent {
  /// The list of posts to save to the local database.
  final List<Post> posts;

  /// Creates a [SaveOfflinePostsEvent] instance.
  ///
  /// The [posts] argument specifies the list of posts to save to the local
  /// database.
  SaveOfflinePostsEvent(this.posts);

  @override
  List<Object> get props => [posts];
}
