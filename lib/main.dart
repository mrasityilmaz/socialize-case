import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:my_coding_setup/core/services/navigator_service.dart';
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

  await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  await FirebaseStorage.instance.useStorageEmulator('localhost', 9199);
  FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);

  ///
  /// Configure Dependencies for the GetIt Service Locator
  ///
  await configureDependencies(defaultEnv: 'real');
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SignUpViewModel()),
        ChangeNotifierProvider(create: (_) => SignInViewModel()),
        ChangeNotifierProvider(create: (_) => PersonalInformationViewModel()),
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
