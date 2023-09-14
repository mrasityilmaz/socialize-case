import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_model.freezed.dart';
part 'post_model.g.dart';

@Freezed()
class PostModel extends Equatable with _$PostModel {
  const factory PostModel({
    required final String id,
    required final String userId,
    required final String userName,
    @JsonKey(defaultValue: 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png') required final String userImageUrl,
    required final String imageUrl,
    @JsonKey(fromJson: _dateTimeFromTimestamp, toJson: _dateTimeToTimestamp) required final DateTime createdAt,
    @Default(0) final int? likesCount,
    @Default('') final String? description,
  }) = _PostModel;

  const PostModel._();

  factory PostModel.fromJson(Map<String, dynamic> json) => _$PostModelFromJson(json);

  @override
  List<Object?> get props => [
        id,
        userId,
        imageUrl,
        userImageUrl,
        createdAt,
        likesCount,
        description,
      ];

  static bool isOkey(Map<String, dynamic> json) {
    final clearList =
        json.entries.map((e) => (e.key != 'likesCount' || e.key != 'description') ? e : null).where((element) => element != null).map((e) => e!).toList().cast<MapEntry<String, dynamic>>();
    if (clearList.any((element) => element.value == null) && clearList.length <= 6) {
      return false;
    } else {
      return true;
    }
  }
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
