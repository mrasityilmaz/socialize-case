import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_coding_setup/core/enums/routes/routes_enum.dart';
import 'package:my_coding_setup/core/extensions/context_extension.dart';
import 'package:my_coding_setup/core/services/validator_service.dart';
import 'package:my_coding_setup/features/components/base_viewmodel_builder/base_viewmodel_builder.dart';
import 'package:my_coding_setup/features/components/widgets/buttons/custom_button.dart';
import 'package:my_coding_setup/features/components/widgets/text_field/with_formfield.dart';
import 'package:my_coding_setup/features/sign_up/sign_up_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:svg_flutter/svg.dart';

part 'widgets/bottom_body.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CustomViewModelBuilder<SignUpViewModel>(
        child: _SignUpScreenBodyWidget(),
      ),
    );
  }
}
