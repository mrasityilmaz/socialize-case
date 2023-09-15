import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_coding_setup/core/enums/routes/routes_enum.dart';
import 'package:my_coding_setup/core/services/user_service.dart';
import 'package:my_coding_setup/features/bottom_nav_bar_views/create_post/create_post_view.dart';
import 'package:my_coding_setup/features/edit_profile/edit_profile_view.dart';
import 'package:my_coding_setup/features/main/main_view.dart';
import 'package:my_coding_setup/features/personal_information/personal_information_view.dart';
import 'package:my_coding_setup/features/sign_in/sign_in_screen.dart';
import 'package:my_coding_setup/features/sign_up/sign_up_screen.dart';
import 'package:my_coding_setup/injection/injection_container.dart';

final class GoRouterService {
  factory GoRouterService() => instance;

  GoRouterService._internal();

  static final GoRouterService instance = GoRouterService._internal();

  final GoRouter _goRouter = GoRouter(
    routes: [
      GoRoute(
        path: RouteNames.signIn.path,
        builder: (context, state) => const SignInScreen(),
        redirect: (context, state) async {
          if (FirebaseAuth.instance.currentUser != null && locator<UserService>().userModel != null) {
            return RouteNames.main.path;
          }
          return null;
        },
        name: RouteNames.signIn.name,
        pageBuilder: (context, state) {
          return _pageBuilder(context, state, const SignInScreen());
        },
      ),
      GoRoute(
        path: RouteNames.signUp.path,
        builder: (context, state) => const SignUpScreen(),
        name: RouteNames.signUp.name,
        pageBuilder: (context, state) {
          return _pageBuilder(context, state, const SignUpScreen());
        },
      ),
      GoRoute(
        path: RouteNames.personalInformation.path,
        builder: (context, state) => const PersonalInformation(),
        name: RouteNames.personalInformation.name,
        pageBuilder: (context, state) {
          return _pageBuilder(context, state, const PersonalInformation());
        },
      ),
      GoRoute(
        path: RouteNames.main.path,
        builder: (context, state) => const MainView(),
        name: RouteNames.main.name,
        pageBuilder: (context, state) {
          return _pageBuilder(context, state, const MainView());
        },
      ),
      GoRoute(
        path: RouteNames.createPost.path,
        builder: (context, state) => const CreatePostView(),
        name: RouteNames.createPost.name,
        pageBuilder: (context, state) {
          return _pageBuilder(context, state, const CreatePostView());
        },
      ),
      GoRoute(
        path: RouteNames.editProfile.path,
        builder: (context, state) => const EditProfileView(),
        name: RouteNames.editProfile.name,
        pageBuilder: (context, state) {
          return _pageBuilder(context, state, const EditProfileView());
        },
      ),
    ],
  );

  GoRouter get goRouter => _goRouter;

  static Page<dynamic> _pageBuilder(BuildContext context, GoRouterState state, Widget child) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1, 0);
        const end = Offset.zero;
        const curve = Curves.ease;

        final tween = Tween(begin: begin, end: end);
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: curve,
        );

        return SlideTransition(
          position: tween.animate(curvedAnimation),
          child: child,
        );
      },
    );
  }
}
