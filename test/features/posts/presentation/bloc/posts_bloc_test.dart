import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ninjaz_posts_app/core/services/service_locator.dart';
import 'package:ninjaz_posts_app/features/posts/domain/entities/post.dart';
import 'package:ninjaz_posts_app/features/posts/domain/repository/posts_base_repo.dart';
import 'package:ninjaz_posts_app/features/posts/domain/usecases/clear_offline_posts_usecase.dart';
import 'package:ninjaz_posts_app/features/posts/domain/usecases/get_post_usecase.dart';
import 'package:ninjaz_posts_app/features/posts/domain/usecases/get_posts_offline_usecase.dart';
import 'package:ninjaz_posts_app/features/posts/domain/usecases/get_posts_usecase.dart';
import 'package:ninjaz_posts_app/features/posts/domain/usecases/save_posts_offline_usecase.dart';
import 'package:ninjaz_posts_app/features/posts/presentation/bloc/posts_bloc.dart';

import '../../domain/usecases/posts_repo_mock.dart';

void main() {
  late PostsBloc postsBloc;
  late PostsBaseRepo repo;
  late GetPostsUsecase getPostsUsecase;
  late GetPostUsecase getPostUsecase;
  late GetOfflinePostsUsecase getOfflinePostsUsecase;
  late ClearOfflinePostsUsecase clearOfflinePostsUsecase;
  late SaveOfflinePostsUsecase saveOfflinePostsUsecase;

  setUp(() {
    repo = MockPostsRepo();
    getPostsUsecase = GetPostsUsecase(repo);
    getPostUsecase = GetPostUsecase(repo);
    getOfflinePostsUsecase = GetOfflinePostsUsecase(repo);
    clearOfflinePostsUsecase = ClearOfflinePostsUsecase(repo);
    saveOfflinePostsUsecase = SaveOfflinePostsUsecase(repo);

    postsBloc = PostsBloc(
      getPostUsecase,
      getPostsUsecase,
      getOfflinePostsUsecase,
      clearOfflinePostsUsecase,
      saveOfflinePostsUsecase,
    );
  });

  setUpAll(() => ServiceLocator.init());

  group(
    'postsBloc',
    () {
      test('initial state is an empty state', () {
        expect(
          postsBloc.state,
          PostsState(
            status: PostsStatus.initial,
            posts: [],
            error: '',
            currentPostDetails: null,
          ),
        );
      });

      blocTest<PostsBloc, PostsState>(
        'emits [Post] when GetPostsEvent is added',
        build: () => postsBloc,
        act: (bloc) => bloc.add(GetPostsEvent(0)),
        expect: () => <Post>[],
      );
    },
  );
}
