// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_entity.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class PostEntity extends _PostEntity
    with RealmEntity, RealmObjectBase, RealmObject {
  PostEntity(
    String id,
    String text,
    String image,
    int likes,
    String publishDate, {
    OwnerEntity? owner,
    Iterable<String> tags = const [],
  }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'text', text);
    RealmObjectBase.set(this, 'image', image);
    RealmObjectBase.set(this, 'likes', likes);
    RealmObjectBase.set(this, 'publishDate', publishDate);
    RealmObjectBase.set(this, 'owner', owner);
    RealmObjectBase.set<RealmList<String>>(
        this, 'tags', RealmList<String>(tags));
  }

  PostEntity._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get text => RealmObjectBase.get<String>(this, 'text') as String;
  @override
  set text(String value) => RealmObjectBase.set(this, 'text', value);

  @override
  String get image => RealmObjectBase.get<String>(this, 'image') as String;
  @override
  set image(String value) => RealmObjectBase.set(this, 'image', value);

  @override
  int get likes => RealmObjectBase.get<int>(this, 'likes') as int;
  @override
  set likes(int value) => RealmObjectBase.set(this, 'likes', value);

  @override
  RealmList<String> get tags =>
      RealmObjectBase.get<String>(this, 'tags') as RealmList<String>;
  @override
  set tags(covariant RealmList<String> value) =>
      throw RealmUnsupportedSetError();

  @override
  String get publishDate =>
      RealmObjectBase.get<String>(this, 'publishDate') as String;
  @override
  set publishDate(String value) =>
      RealmObjectBase.set(this, 'publishDate', value);

  @override
  OwnerEntity? get owner =>
      RealmObjectBase.get<OwnerEntity>(this, 'owner') as OwnerEntity?;
  @override
  set owner(covariant OwnerEntity? value) =>
      RealmObjectBase.set(this, 'owner', value);

  @override
  Stream<RealmObjectChanges<PostEntity>> get changes =>
      RealmObjectBase.getChanges<PostEntity>(this);

  @override
  PostEntity freeze() => RealmObjectBase.freezeObject<PostEntity>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(PostEntity._);
    return const SchemaObject(
        ObjectType.realmObject, PostEntity, 'PostEntity', [
      SchemaProperty('id', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('text', RealmPropertyType.string),
      SchemaProperty('image', RealmPropertyType.string),
      SchemaProperty('likes', RealmPropertyType.int),
      SchemaProperty('tags', RealmPropertyType.string,
          collectionType: RealmCollectionType.list),
      SchemaProperty('publishDate', RealmPropertyType.string),
      SchemaProperty('owner', RealmPropertyType.object,
          optional: true, linkTarget: 'OwnerEntity'),
    ]);
  }
}

class OwnerEntity extends _OwnerEntity
    with RealmEntity, RealmObjectBase, RealmObject {
  OwnerEntity(
    String id,
    String title,
    String firstName,
    String lastName,
    String picture,
  ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'title', title);
    RealmObjectBase.set(this, 'firstName', firstName);
    RealmObjectBase.set(this, 'lastName', lastName);
    RealmObjectBase.set(this, 'picture', picture);
  }

  OwnerEntity._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get title => RealmObjectBase.get<String>(this, 'title') as String;
  @override
  set title(String value) => RealmObjectBase.set(this, 'title', value);

  @override
  String get firstName =>
      RealmObjectBase.get<String>(this, 'firstName') as String;
  @override
  set firstName(String value) => RealmObjectBase.set(this, 'firstName', value);

  @override
  String get lastName =>
      RealmObjectBase.get<String>(this, 'lastName') as String;
  @override
  set lastName(String value) => RealmObjectBase.set(this, 'lastName', value);

  @override
  String get picture => RealmObjectBase.get<String>(this, 'picture') as String;
  @override
  set picture(String value) => RealmObjectBase.set(this, 'picture', value);

  @override
  Stream<RealmObjectChanges<OwnerEntity>> get changes =>
      RealmObjectBase.getChanges<OwnerEntity>(this);

  @override
  OwnerEntity freeze() => RealmObjectBase.freezeObject<OwnerEntity>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(OwnerEntity._);
    return const SchemaObject(
        ObjectType.realmObject, OwnerEntity, 'OwnerEntity', [
      SchemaProperty('id', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('title', RealmPropertyType.string),
      SchemaProperty('firstName', RealmPropertyType.string),
      SchemaProperty('lastName', RealmPropertyType.string),
      SchemaProperty('picture', RealmPropertyType.string),
    ]);
  }
}
