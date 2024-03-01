import 'package:realm/realm.dart';
part 'post_entity.g.dart';

/// A model class for storing post data in Realm database.
@RealmModel()
class _PostEntity {
  /// A unique identifier for the post.
  @PrimaryKey()
  late String id;

  /// The text content of the post.
  late String text;

  /// The URL of the image associated with the post.
  late String image;

  /// The number of likes the post has received.
  late int likes;

  /// A list of tags associated with the post.
  late List<String> tags;

  /// The date the post was published.
  late String publishDate;

  /// The owner of the post.
  late _OwnerEntity? owner;
}

/// A model class for storing post owner data in Realm database.
@RealmModel()
class _OwnerEntity {
  /// A unique identifier for the owner.
  @PrimaryKey()
  late String id;

  /// The title of the owner.
  late String title;

  /// The first name of the owner.
  late String firstName;

  /// The last name of the owner.
  late String lastName;

  /// The URL of the owner's profile picture.
  late String picture;
}
