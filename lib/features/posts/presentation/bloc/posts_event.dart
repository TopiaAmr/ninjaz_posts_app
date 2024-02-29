part of 'posts_bloc.dart';

abstract class PostsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetPostsEvent extends PostsEvent {
  final int page;

  GetPostsEvent(this.page);

  @override
  List<Object> get props => [page];
}

class GetPostEvent extends PostsEvent {
  final String id;

  GetPostEvent(this.id);

  @override
  List<Object> get props => [id];
}
