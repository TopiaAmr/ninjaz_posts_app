import 'package:flutter/material.dart';
import 'package:ninjaz_posts_app/features/posts/domain/entities/post.dart';

class PostItemWidget extends StatelessWidget {
  const PostItemWidget({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Text(post.text);
  }
}
