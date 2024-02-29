part of 'posts_bloc.dart';

abstract class PostsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetPostsEvent extends PostsEvent {
  GetPostsEvent();

  @override
  List<Object> get props => [];
}

class GetPostEvent extends PostsEvent {
  final String id;

  GetPostEvent(this.id);

  @override
  List<Object> get props => [id];
}
