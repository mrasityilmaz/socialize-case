// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PostModel _$$_PostModelFromJson(Map<String, dynamic> json) => _$_PostModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      userImageUrl: json['userImageUrl'] as String? ??
          'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
      imageUrl: json['imageUrl'] as String,
      createdAt: _dateTimeFromTimestamp(json['createdAt']),
      likesCount: json['likesCount'] as int? ?? 0,
      description: json['description'] as String? ?? '',
    );

Map<String, dynamic> _$$_PostModelToJson(_$_PostModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'userName': instance.userName,
      'userImageUrl': instance.userImageUrl,
      'imageUrl': instance.imageUrl,
      'createdAt': _dateTimeToTimestamp(instance.createdAt),
      'likesCount': instance.likesCount,
      'description': instance.description,
    };
