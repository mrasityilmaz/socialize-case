import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_coding_setup/core/enums/routes/routes_enum.dart';
import 'package:my_coding_setup/core/extensions/context_extension.dart';
import 'package:my_coding_setup/core/extensions/dartz_extension.dart';
import 'package:my_coding_setup/core/services/navigator_service.dart';
import 'package:my_coding_setup/core/services/validator_service.dart';
import 'package:my_coding_setup/features/components/base_viewmodel_builder/base_viewmodel_builder.dart';
import 'package:my_coding_setup/features/components/widgets/buttons/custom_button.dart';
import 'package:my_coding_setup/features/components/widgets/text_field/with_formfield.dart';
import 'package:my_coding_setup/features/sign_in/sign_in_viewmodel.dart';
import 'package:my_coding_setup/features/sign_in/widgets/sign_screen_bg_design_widget.dart';
import 'package:provider/provider.dart';

part 'widgets/bottom_body.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CustomViewModelBuilder<SignInViewModel>(
        child: SignScreenBackgroundDesignWidget(child: _SignInScreenBodyWidget()),
      ),
    );
  }
}
