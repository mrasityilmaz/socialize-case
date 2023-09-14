import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_coding_setup/core/enums/routes/routes_enum.dart';
import 'package:my_coding_setup/features/components/widgets/buttons/custom_button.dart';
import 'package:my_coding_setup/features/components/widgets/text/custom_text_widget.dart';

final class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: SafeArea(
        child: Column(
          children: [
            const CustomTextWidget(
              text: 'You did it!',
            ),
            CustomButtonWidget(
              text: 'Sign Out',
              onPressed: () async {
                await FirebaseAuth.instance.signOut().whenComplete(() => context.pushReplacementNamed(RouteNames.signIn.name));
              },
            ),
          ],
        ),
      ),
    );
  }
}
