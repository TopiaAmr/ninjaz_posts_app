import 'package:realm/realm.dart';
part 'post_entity.g.dart';

@RealmModel()
class _PostEntity {
  @PrimaryKey()
  late String id;
  late String text;
  late String image;
  late int likes;
  late List<String> tags;
  late String publishDate;
  late _OwnerEntity? owner;
}

@RealmModel()
class _OwnerEntity {
  @PrimaryKey()
  late String id;
  late String title;
  late String firstName;
  late String lastName;
  late String picture;
}
