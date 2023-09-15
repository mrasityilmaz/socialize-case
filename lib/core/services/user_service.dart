import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:my_coding_setup/core/enums/routes/routes_enum.dart';
import 'package:my_coding_setup/core/extensions/dartz_extension.dart';
import 'package:my_coding_setup/core/services/like_service.dart';
import 'package:my_coding_setup/core/services/saved_post_service.dart';
import 'package:my_coding_setup/data/models/user_models/user_model/user_model.dart';
import 'package:my_coding_setup/domain/repositories/user_repository/i_auth_repository.dart';
import 'package:my_coding_setup/features/bottom_nav_bar_views/home/home_viewmodel.dart';
import 'package:my_coding_setup/injection/injection_container.dart';
import 'package:provider/provider.dart';

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
    notifyListeners();
  }

  Future<void> syncUser() async {
    await locator<IUserRepository>().getUserProfile().then((value) {
      if (value.isRight()) {
        setUserModel(value.asRight());
      }
    });
  }

  Future<void> logout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut().whenComplete(() {
        setUserModel(null);
        locator<LikeService>().setMyLikedPostIds([]);
        locator<SavedPostService>().setMySavedPostIds([]);
        context.read<HomeViewModel>().setPostList([]);
        context.goNamed(RouteNames.signIn.name);
      });
    } catch (e) {
      await FirebaseAuth.instance.signOut().whenComplete(() => context.goNamed(RouteNames.signIn.name));
    }
  }
}
