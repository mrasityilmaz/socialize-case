// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserDataModel _$$_UserDataModelFromJson(Map<String, dynamic> json) =>
    _$_UserDataModel(
      email: json['email'] as String?,
      userId: json['userId'] as String?,
      fullname: json['fullname'] as String?,
      username: json['username'] as String?,
      profileImageUrl: json['profileImageUrl'] as String? ??
          'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
      bio: json['bio'] as String?,
    );

Map<String, dynamic> _$$_UserDataModelToJson(_$_UserDataModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'userId': instance.userId,
      'fullname': instance.fullname,
      'username': instance.username,
      'profileImageUrl': instance.profileImageUrl,
      'bio': instance.bio,
    };
