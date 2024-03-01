import 'package:flutter/material.dart';
import 'package:ninjaz_posts_app/features/posts/domain/entities/post.dart';
import 'package:ninjaz_posts_app/features/posts/presentation/widgets/post_item_widget.dart';
import 'package:shimmer/shimmer.dart';

const Map<String, dynamic> _singlePost = {
  "id": "60d21aed67d0d8992e610b7f",
  "image": "https://img.dummyapi.io/photo-1582490738676-9ea599096c68.jpg",
  "likes": 13,
  "link": "https://www.discover194.com/",
  "tags": ["animal", "dog", "canine"],
  "text": "Dog giving a high five white and black long coat small dog",
  "publishDate": "2019-11-07T16:42:30.296Z",
  "owner": {
    "id": "60d0fe4f5311236168a109ff",
    "title": "mrs",
    "firstName": "Josefina",
    "lastName": "Calvo",
    "picture": "https://randomuser.me/api/portraits/med/women/3.jpg"
  }
};

/// A loading shimmer list of posts
class LoadingShimmerList extends StatelessWidget {
  /// Creates a loading shimmer list of posts
  const LoadingShimmerList({super.key});

  @override
  Widget build(BuildContext context) {
    final fakePost = Post.fromJson(_singlePost);
    return SingleChildScrollView(
      child: Column(
        children: [
          Shimmer(
            /// The shimmer gradient
            gradient: const LinearGradient(colors: [
              Colors.grey,
              Colors.white,
            ]),

            /// The post item widget to be displayed
            child: PostItemWidget(
              post: fakePost,
            ),
          ),
          Shimmer(
            gradient: const LinearGradient(colors: [
              Colors.grey,
              Colors.white,
            ]),
            child: PostItemWidget(
              post: fakePost,
            ),
          ),
          Shimmer(
            gradient: const LinearGradient(colors: [
              Colors.grey,
              Colors.white,
            ]),
            child: PostItemWidget(
              post: fakePost,
            ),
          ),
        ],
      ),
    );
  }
}
