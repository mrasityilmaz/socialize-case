import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_coding_setup/core/enums/custom_text_style_enum/text_style_enum.dart';
import 'package:my_coding_setup/core/enums/routes/routes_enum.dart';
import 'package:my_coding_setup/core/extensions/context_extension.dart';
import 'package:my_coding_setup/features/components/widgets/buttons/custom_button.dart';
import 'package:my_coding_setup/features/components/widgets/text/custom_text_widget.dart';
import 'package:my_coding_setup/features/components/widgets/text_field/text_field.dart';
import 'package:my_coding_setup/features/personal_information/personal_information_viewmodel.dart';
import 'package:provider/provider.dart';

part 'widgets/profile_photo_widget.dart';

final class PersonalInformation extends StatelessWidget {
  const PersonalInformation({super.key});

  @override
  Widget build(BuildContext context) {
    final PersonalInformationViewModel viewModel = context.read<PersonalInformationViewModel>();
    final bool isReadyForNextStep = context.select<PersonalInformationViewModel, bool>((value) => value.profilePhoto != null && !value.isBusy);
    return Scaffold(
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: context.paddingNormal,
          child: CustomButtonWidget(
            text: 'Continue to Our World',
            onPressed: isReadyForNextStep
                ? () async {
                    await viewModel.uploadAndNext().whenComplete(() => context.goNamed(RouteNames.signIn.name));
                  }
                : null,
          ),
        ),
      ),
      body: const _BodyWidget(),
    );
  }
}

final class _BodyWidget extends StatelessWidget {
  const _BodyWidget();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: context.paddingNormalTop + context.paddingNormalHorizontal,
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            children: [
              CustomTextWidget(text: 'Congratulations!', style: CustomTextStyleEnum.s24w600, textColor: context.theme.primaryColor),
              SizedBox(height: context.lowValue),
              CustomTextWidget(
                text: 'Your Account has been created successfully',
                textColor: context.colors.onBackground.withOpacity(.5),
              ),
              SizedBox(height: context.normalValue),
              const CustomTextWidget(
                text: 'Finally, you must add a profile picture to your account.',
                style: CustomTextStyleEnum.s17w600,
              ),
              SizedBox(height: context.normalValue),
              const _ProfilePhotoWidget(),
              SizedBox(height: context.lowValue),
              const Text('Add Profile Picture'),
              SizedBox(height: context.mediumValue),
              const CustomTextWidget(
                text: 'Either you can add a bio to your account or you can skip this step.',
                style: CustomTextStyleEnum.s17w600,
              ),
              SizedBox(height: context.normalValue),
              SizedBox(
                height: 36 * 4,
                child: CustomTextFieldWidget(
                  controller: context.read<PersonalInformationViewModel>().bioController,
                  hintText: 'Add Bio',
                  maxLines: 5,
                  maxLength: 300,
                  expands: true,
                  textInputType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                ),
              ),
              SizedBox(height: context.normalValue),
            ],
          ),
        ),
      ),
    );
  }
}
