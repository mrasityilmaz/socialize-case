import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_coding_setup/data/models/user_models/user_data_model/user_data_model.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@Freezed()
class UserModel extends Equatable with _$UserModel {
  const factory UserModel({
    required final UserDataModel userDataModel,
    required final List<String> searchOptions,
    @Default([]) final List<String> followers,
    @Default([]) final List<String> following,
    @Default([]) final List<String> likedPosts,
    @Default([]) final List<String> savedPosts,
    @JsonKey(fromJson: _dateTimeFromTimestamp, toJson: _dateTimeToTimestamp) final DateTime? createdAt,
    @JsonKey(fromJson: _dateTimeFromTimestamp, toJson: _dateTimeToTimestamp) final DateTime? updatedAt,
  }) = _UserModel;

  const UserModel._();

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  @override
  List<Object?> get props => [
        userDataModel,
        followers,
        following,
        likedPosts,
        savedPosts,
        createdAt,
        updatedAt,
      ];
}

DateTime _dateTimeFromTimestamp(dynamic json) {
  if (json == null) {
    return DateTime.now().toUtc();
  } else if (json is String) {
    return DateTime.parse(json).toUtc();
  } else {
    return (json as int?) != null ? DateTime.fromMillisecondsSinceEpoch(json!).toUtc() : DateTime.now().toUtc();
  }
}

int? _dateTimeToTimestamp(DateTime? dateTime) {
  if (dateTime == null) return null;
  return dateTime.millisecondsSinceEpoch;
}
