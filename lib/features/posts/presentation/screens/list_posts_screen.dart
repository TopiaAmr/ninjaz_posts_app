import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:lottie/lottie.dart';
import 'package:ninjaz_posts_app/core/services/service_locator.dart';
import 'package:ninjaz_posts_app/features/posts/presentation/bloc/posts_bloc.dart';
import 'package:ninjaz_posts_app/features/posts/presentation/widgets/plane_indicator.dart';

class ListOfPostsScreen extends StatefulWidget {
  const ListOfPostsScreen({super.key});

  @override
  State<ListOfPostsScreen> createState() => _ListOfPostsScreenState();
}

class _ListOfPostsScreenState extends State<ListOfPostsScreen> {
  final ScrollController controller = ScrollController();

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
              child: CircularProgressIndicator(),
            );
          case PostsStatus.loading:
          case PostsStatus.success:
            if (state.posts.isEmpty) {
              return Center(
                child: TextButton(
                  child: Text('No posts found'),
                  onPressed: () async {
                    final bool hasInternet =
                        await getIt<InternetConnection>().hasInternetAccess;
                    print(hasInternet);
                    if (!hasInternet) {
                      context.read<PostsBloc>().add(GetOfflinePostsEvent());
                    } else {
                      context.read<PostsBloc>().add((ClearOfflinePostsEvent()));
                      context.read<PostsBloc>().add(GetPostsEvent(0));
                    }
                  },
                ),
              );
            }
            return PlaneIndicator(
              onRefresh: () async {
                if (!await getIt<InternetConnection>().hasInternetAccess) {
                  context.read<PostsBloc>().add(GetOfflinePostsEvent());
                } else {
                  context.read<PostsBloc>().add((ClearOfflinePostsEvent()));
                  context.read<PostsBloc>().add(GetPostsEvent(0));
                }
              },
              child: ListView.builder(
                itemCount: state.posts.length + 1,
                controller: controller,
                itemBuilder: (context, index) {
                  if (index < state.posts.length) {
                    final post = state.posts[index];
                    return ListTile(
                      title: Text(post.text),
                    );
                  }
                  return state.isOffline
                      ? SizedBox.shrink()
                      : LinearProgressIndicator();
                },
              ),
            );
          case PostsStatus.failure:
            return PlaneIndicator(
              onRefresh: () async {
                if (!await getIt<InternetConnection>().hasInternetAccess) {
                  context.read<PostsBloc>().add(GetOfflinePostsEvent());
                } else {
                  context.read<PostsBloc>().add((ClearOfflinePostsEvent()));
                  context.read<PostsBloc>().add(GetPostsEvent(0));
                }
              },
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 32,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Lottie.asset('assets/loading_error.json'),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Something went wrong, please try again",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
        }
      },
    );
  }
}
