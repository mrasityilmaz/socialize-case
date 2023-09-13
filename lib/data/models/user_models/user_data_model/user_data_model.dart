import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_data_model.freezed.dart';
part 'user_data_model.g.dart';

@Freezed()
class UserDataModel extends Equatable with _$UserDataModel {
  const factory UserDataModel({
    final String? email,
    final String? userId,
    final String? fullname,
    final String? username,
    @Default('https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png') final String profileImageUrl,
    final String? bio,
  }) = _UserDataModel;

  const UserDataModel._();

  factory UserDataModel.fromJson(Map<String, dynamic> json) => _$UserDataModelFromJson(json);

  @override
  List<Object?> get props => [
        email,
        userId,
        fullname,
        username,
        profileImageUrl,
        bio,
      ];
}
