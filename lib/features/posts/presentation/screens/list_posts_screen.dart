import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:ninjaz_posts_app/core/services/service_locator.dart';
import 'package:ninjaz_posts_app/features/posts/presentation/bloc/posts_bloc.dart';

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
    getIt<InternetConnection>().hasInternetAccess.then((isConnected) {
      if (!isConnected) {
        context.read<PostsBloc>().add(GetOfflinePostsEvent());
      } else {
        context.read<PostsBloc>().add((ClearOfflinePostsEvent()));
        context.read<PostsBloc>().add(GetPostsEvent(page));
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
              return const Center(
                child: Text('No posts found'),
              );
            }
            return ListView.builder(
              itemCount: state.posts.length + 1,
              controller: controller,
              itemBuilder: (context, index) {
                if (index < state.posts.length) {
                  final post = state.posts[index];
                  return ListTile(
                    title: Text(post.text),
                  );
                }
                return LinearProgressIndicator();
              },
            );
          case PostsStatus.failure:
            return Center(
              child: Text(state.error),
            );
        }
      },
    );
  }
}
