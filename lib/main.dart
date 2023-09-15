import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_coding_setup/core/services/like_service.dart';
import 'package:my_coding_setup/core/services/navigator_service.dart';
import 'package:my_coding_setup/core/services/saved_post_service.dart';
import 'package:my_coding_setup/core/services/user_service.dart';
import 'package:my_coding_setup/features/bottom_nav_bar_views/create_post/create_post_viewmodel.dart';
import 'package:my_coding_setup/features/bottom_nav_bar_views/home/home_viewmodel.dart';
import 'package:my_coding_setup/features/bottom_nav_bar_views/likes_and_saves/likes_and_saves_viewmodel.dart';
import 'package:my_coding_setup/features/bottom_nav_bar_views/profile/profile_viewmodel.dart';
import 'package:my_coding_setup/features/bottom_nav_bar_views/search/search_viewmodel.dart';
import 'package:my_coding_setup/features/edit_profile/edit_profile_viewmodel.dart';
import 'package:my_coding_setup/features/main/main_viewmodel.dart';
import 'package:my_coding_setup/features/personal_information/personal_information_viewmodel.dart';
import 'package:my_coding_setup/features/sign_in/sign_in_viewmodel.dart';
import 'package:my_coding_setup/features/sign_up/sign_up_viewmodel.dart';
import 'package:my_coding_setup/firebase_options.dart';
import 'package:my_coding_setup/injection/injection_container.dart';
import 'package:my_coding_setup/shared/app_theme.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  ///
  /// Configure Dependencies for the GetIt Service Locator
  ///
  await configureDependencies(defaultEnv: 'real');

  if (FirebaseAuth.instance.currentUser != null) {
    await locator<UserService>().syncUser();
  }
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SignUpViewModel()),
        ChangeNotifierProvider(create: (_) => SignInViewModel()),
        ChangeNotifierProvider(create: (_) => PersonalInformationViewModel()),
        ChangeNotifierProvider(create: (_) => MainViewModel()),
        ChangeNotifierProvider(create: (_) => CreatePostViewModel()),
        ChangeNotifierProvider(create: (_) => EditProfileViewModel()),
        ChangeNotifierProvider(
          create: (_) => HomeViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => SearchViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => LikesAndSavesViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProfileViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => UserService(),
        ),
        ChangeNotifierProvider(
          create: (_) => LikeService(),
        ),
        ChangeNotifierProvider(
          create: (_) => SavedPostService(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme().themeData,
      routerConfig: GoRouterService.instance.goRouter,
    );
  }
}
