import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:my_coding_setup/core/extensions/dartz_extension.dart';
import 'package:my_coding_setup/core/services/like_service.dart';
import 'package:my_coding_setup/core/services/saved_post_service.dart';
import 'package:my_coding_setup/data/models/user_models/user_model/user_model.dart';
import 'package:my_coding_setup/domain/repositories/user_repository/i_auth_repository.dart';
import 'package:my_coding_setup/injection/injection_container.dart';

@lazySingleton
final class UserService extends ChangeNotifier {
  factory UserService() => instance;

  UserService._internal();

  static final UserService instance = UserService._internal();

  UserModel? _userModel;

  UserModel? get userModel => _userModel;

  void setUserModel(UserModel? value) {
    _userModel = value;

    locator<LikeService>().setMyLikedPostIds(value?.likedPosts ?? List.empty(growable: true));
    locator<SavedPostService>().setMySavedPostIds(value?.savedPosts ?? List.empty(growable: true));
  }

  Future<void> syncUser() async {
    await locator<IUserRepository>().getUserProfile().then((value) {
      if (value.isRight()) {
        setUserModel(value.asRight());
      }
    });
  }
}
