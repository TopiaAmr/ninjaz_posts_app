import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:ninjaz_posts_app/features/posts/domain/entities/post.dart';

class PostItemWidget extends StatelessWidget {
  const PostItemWidget({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: post.image,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => const Placeholder(),
                height: MediaQuery.of(context).size.height * 0.25,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.25,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black87],
                stops: const [0.5, 1],
              ),
            ),
          ),
          Positioned(
            top: 20,
            right: 20,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(5),
              ),
              padding: EdgeInsets.all(5),
              child: Row(
                children: [
                  Text(
                    post.likes.toString(),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 5),
                  Icon(
                    Icons.thumb_up_alt_outlined,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 20,
            left: 20,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Wrap(
              children: post.tags
                  .take(3)
                  .map(
                    (e) => Container(
                      margin: EdgeInsets.only(right: 5),
                      child: Chip(
                        label: Text(e),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Column(
              children: [
                Text(
                  post.text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage:
                              CachedNetworkImageProvider(post.owner.picture),
                          radius: 14,
                        ),
                        SizedBox(width: 5),
                        Text(
                          "${post.owner.firstName} ${post.owner.lastName}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.yellow,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      timeago.format(DateTime.parse(post.publishDate)),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.yellow,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
