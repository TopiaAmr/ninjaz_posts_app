// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PostImpl _$$PostImplFromJson(Map<String, dynamic> json) => _$PostImpl(
      id: json['id'] as String,
      text: json['text'] as String,
      image: json['image'] as String,
      likes: json['likes'] as int,
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      publishDate: json['publishDate'] as String,
      owner: Owner.fromJson(json['owner'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$PostImplToJson(_$PostImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'image': instance.image,
      'likes': instance.likes,
      'tags': instance.tags,
      'publishDate': instance.publishDate,
      'owner': instance.owner,
    };
