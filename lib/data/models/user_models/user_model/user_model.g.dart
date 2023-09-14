// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserModel _$$_UserModelFromJson(Map<String, dynamic> json) => _$_UserModel(
      userDataModel:
          UserDataModel.fromJson(json['userDataModel'] as Map<String, dynamic>),
      searchOptions: (json['searchOptions'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      followers: (json['followers'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      following: (json['following'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      likedPosts: (json['likedPosts'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      savedPosts: (json['savedPosts'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      createdAt: _dateTimeFromTimestamp(json['createdAt']),
      updatedAt: _dateTimeFromTimestamp(json['updatedAt']),
    );

Map<String, dynamic> _$$_UserModelToJson(_$_UserModel instance) =>
    <String, dynamic>{
      'userDataModel': instance.userDataModel.toJson(),
      'searchOptions': instance.searchOptions,
      'followers': instance.followers,
      'following': instance.following,
      'likedPosts': instance.likedPosts,
      'savedPosts': instance.savedPosts,
      'createdAt': _dateTimeToTimestamp(instance.createdAt),
      'updatedAt': _dateTimeToTimestamp(instance.updatedAt),
    };
