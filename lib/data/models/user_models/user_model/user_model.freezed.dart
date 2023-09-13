// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return _UserModel.fromJson(json);
}

/// @nodoc
mixin _$UserModel {
  UserDataModel get userDataModel => throw _privateConstructorUsedError;
  List<String> get followers => throw _privateConstructorUsedError;
  List<String> get following => throw _privateConstructorUsedError;
  List<String> get likedPosts => throw _privateConstructorUsedError;
  List<String> get savedPosts => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserModelCopyWith<UserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserModelCopyWith<$Res> {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) then) =
      _$UserModelCopyWithImpl<$Res, UserModel>;
  @useResult
  $Res call(
      {UserDataModel userDataModel,
      List<String> followers,
      List<String> following,
      List<String> likedPosts,
      List<String> savedPosts,
      DateTime? createdAt,
      DateTime? updatedAt});

  $UserDataModelCopyWith<$Res> get userDataModel;
}

/// @nodoc
class _$UserModelCopyWithImpl<$Res, $Val extends UserModel>
    implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userDataModel = null,
    Object? followers = null,
    Object? following = null,
    Object? likedPosts = null,
    Object? savedPosts = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      userDataModel: null == userDataModel
          ? _value.userDataModel
          : userDataModel // ignore: cast_nullable_to_non_nullable
              as UserDataModel,
      followers: null == followers
          ? _value.followers
          : followers // ignore: cast_nullable_to_non_nullable
              as List<String>,
      following: null == following
          ? _value.following
          : following // ignore: cast_nullable_to_non_nullable
              as List<String>,
      likedPosts: null == likedPosts
          ? _value.likedPosts
          : likedPosts // ignore: cast_nullable_to_non_nullable
              as List<String>,
      savedPosts: null == savedPosts
          ? _value.savedPosts
          : savedPosts // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UserDataModelCopyWith<$Res> get userDataModel {
    return $UserDataModelCopyWith<$Res>(_value.userDataModel, (value) {
      return _then(_value.copyWith(userDataModel: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_UserModelCopyWith<$Res> implements $UserModelCopyWith<$Res> {
  factory _$$_UserModelCopyWith(
          _$_UserModel value, $Res Function(_$_UserModel) then) =
      __$$_UserModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {UserDataModel userDataModel,
      List<String> followers,
      List<String> following,
      List<String> likedPosts,
      List<String> savedPosts,
      DateTime? createdAt,
      DateTime? updatedAt});

  @override
  $UserDataModelCopyWith<$Res> get userDataModel;
}

/// @nodoc
class __$$_UserModelCopyWithImpl<$Res>
    extends _$UserModelCopyWithImpl<$Res, _$_UserModel>
    implements _$$_UserModelCopyWith<$Res> {
  __$$_UserModelCopyWithImpl(
      _$_UserModel _value, $Res Function(_$_UserModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userDataModel = null,
    Object? followers = null,
    Object? following = null,
    Object? likedPosts = null,
    Object? savedPosts = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$_UserModel(
      userDataModel: null == userDataModel
          ? _value.userDataModel
          : userDataModel // ignore: cast_nullable_to_non_nullable
              as UserDataModel,
      followers: null == followers
          ? _value._followers
          : followers // ignore: cast_nullable_to_non_nullable
              as List<String>,
      following: null == following
          ? _value._following
          : following // ignore: cast_nullable_to_non_nullable
              as List<String>,
      likedPosts: null == likedPosts
          ? _value._likedPosts
          : likedPosts // ignore: cast_nullable_to_non_nullable
              as List<String>,
      savedPosts: null == savedPosts
          ? _value._savedPosts
          : savedPosts // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UserModel extends _UserModel {
  const _$_UserModel(
      {required this.userDataModel,
      final List<String> followers = const [],
      final List<String> following = const [],
      final List<String> likedPosts = const [],
      final List<String> savedPosts = const [],
      this.createdAt,
      this.updatedAt})
      : _followers = followers,
        _following = following,
        _likedPosts = likedPosts,
        _savedPosts = savedPosts,
        super._();

  factory _$_UserModel.fromJson(Map<String, dynamic> json) =>
      _$$_UserModelFromJson(json);

  @override
  final UserDataModel userDataModel;
  final List<String> _followers;
  @override
  @JsonKey()
  List<String> get followers {
    if (_followers is EqualUnmodifiableListView) return _followers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_followers);
  }

  final List<String> _following;
  @override
  @JsonKey()
  List<String> get following {
    if (_following is EqualUnmodifiableListView) return _following;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_following);
  }

  final List<String> _likedPosts;
  @override
  @JsonKey()
  List<String> get likedPosts {
    if (_likedPosts is EqualUnmodifiableListView) return _likedPosts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_likedPosts);
  }

  final List<String> _savedPosts;
  @override
  @JsonKey()
  List<String> get savedPosts {
    if (_savedPosts is EqualUnmodifiableListView) return _savedPosts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_savedPosts);
  }

  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UserModelCopyWith<_$_UserModel> get copyWith =>
      __$$_UserModelCopyWithImpl<_$_UserModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserModelToJson(
      this,
    );
  }
}

abstract class _UserModel extends UserModel {
  const factory _UserModel(
      {required final UserDataModel userDataModel,
      final List<String> followers,
      final List<String> following,
      final List<String> likedPosts,
      final List<String> savedPosts,
      final DateTime? createdAt,
      final DateTime? updatedAt}) = _$_UserModel;
  const _UserModel._() : super._();

  factory _UserModel.fromJson(Map<String, dynamic> json) =
      _$_UserModel.fromJson;

  @override
  UserDataModel get userDataModel;
  @override
  List<String> get followers;
  @override
  List<String> get following;
  @override
  List<String> get likedPosts;
  @override
  List<String> get savedPosts;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$_UserModelCopyWith<_$_UserModel> get copyWith =>
      throw _privateConstructorUsedError;
}
