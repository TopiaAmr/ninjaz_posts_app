import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:ninjaz_posts_app/core/services/service_locator.dart';
import 'package:ninjaz_posts_app/features/posts/presentation/bloc/posts_bloc.dart';
import 'package:ninjaz_posts_app/features/posts/presentation/widgets/error_widget.dart';
import 'package:ninjaz_posts_app/features/posts/presentation/widgets/loading_shimmer_list.dart';
import 'package:ninjaz_posts_app/features/posts/presentation/widgets/post_item_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ListOfPostsScreen extends StatefulWidget {
  const ListOfPostsScreen({super.key});

  @override
  State<ListOfPostsScreen> createState() => _ListOfPostsScreenState();
}

class _ListOfPostsScreenState extends State<ListOfPostsScreen> {
  final ScrollController controller = ScrollController();
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    getIt<InternetConnection>().onStatusChange.listen((status) {
      if (status == InternetStatus.connected) {
        context.read<PostsBloc>().add(GetPostsEvent(page));
      } else {
        context.read<PostsBloc>().add((ClearOfflinePostsEvent()));
        context.read<PostsBloc>().add(GetOfflinePostsEvent());
      }
    });
  }

  void _onRefresh() async {
    if (!await getIt<InternetConnection>().hasInternetAccess) {
      context.read<PostsBloc>().add(GetOfflinePostsEvent());
    } else {
      context.read<PostsBloc>().add((ClearOfflinePostsEvent()));
      context.read<PostsBloc>().add(GetPostsEvent(0));
    }
    _refreshController.refreshCompleted();
  }

  int page = 0;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostsBloc, PostsState>(
      bloc: context.read<PostsBloc>(),
      listener: (context, state) {
        controller.addListener(
          () {
            if (controller.positions.isEmpty) {
              return;
            }
            if (state.status == PostsStatus.success &&
                controller.offset == controller.position.maxScrollExtent) {
              setState(() {
                page++;
              });
              context.read<PostsBloc>().add(GetPostsEvent(page));
            }
          },
        );
      },
      builder: (context, state) {
        switch (state.status) {
          case PostsStatus.initial:
            return const Center(
              child: LoadingShimmerList(),
            );
          case PostsStatus.loading:
          case PostsStatus.success:
            if (state.posts.isEmpty) {
              return LoadingShimmerList();
            }
            return SmartRefresher(
              controller: _refreshController,
              onRefresh: _onRefresh,
              child: ListView.builder(
                itemCount: state.posts.length + 1,
                controller: controller,
                itemBuilder: (context, index) {
                  if (index < state.posts.length) {
                    final post = state.posts[index];
                    return PostItemWidget(post: post);
                  }
                  return state.isOffline
                      ? SizedBox.shrink()
                      : LinearProgressIndicator();
                },
              ),
            );
          case PostsStatus.failure:
            return SmartRefresher(
              controller: _refreshController,
              onRefresh: _onRefresh,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: TheErrorWidget(
                  onRefresh: _onRefresh,
                ),
              ),
            );
        }
      },
    );
  }
}
