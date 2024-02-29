import 'package:mocktail/mocktail.dart';
import 'package:ninjaz_posts_app/features/posts/data/datasrouce/posts_local_datasource.dart';
import 'package:ninjaz_posts_app/features/posts/data/datasrouce/posts_remote_datasource.dart';

class PostsRemoteDatasourceMock extends Mock
    implements BasePostsRemoteDatasource {}

class PostsLocalDatasourceMock extends Mock
    implements BasePostsLocalDatasource {}
