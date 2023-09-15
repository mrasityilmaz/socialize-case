import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_coding_setup/core/extensions/context_extension.dart';
import 'package:my_coding_setup/core/services/user_service.dart';
import 'package:my_coding_setup/features/components/base_viewmodel_builder/base_viewmodel_builder.dart';
import 'package:my_coding_setup/features/components/widgets/buttons/custom_button.dart';
import 'package:my_coding_setup/features/components/widgets/text/custom_text_widget.dart';
import 'package:my_coding_setup/features/components/widgets/text_field/text_field.dart';
import 'package:my_coding_setup/features/components/widgets/text_field/with_formfield.dart';
import 'package:my_coding_setup/features/edit_profile/edit_profile_viewmodel.dart';
import 'package:provider/provider.dart';

part 'widgets/profile_photo_widget.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final EditProfileViewModel viewModel = context.read<EditProfileViewModel>();
    final UserService userService = context.read<UserService>();
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: context.colors.onBackground,
          onPressed: () {
            viewModel.clearAll();
            context.pop();
          },
        ),
        title: const CustomTextWidget(text: 'Edit Profile'),
      ),
      body: CustomViewModelBuilder<EditProfileViewModel>(
        onViewModelReady: () {},
        child: Padding(
          padding: context.paddingNormalHorizontal,
          child: Form(
            key: viewModel.formKey,
            child: ListView(
              physics: const ClampingScrollPhysics(),
              children: [
                Text(
                  'Edit account',
                  style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
                ),
                SizedBox(height: context.normalValue * 1.5),
                const _ProfilePhotoWidget(),
                SizedBox(height: context.normalValue * 1.5),
                CustomTextFormFieldWidget(
                  validator: (p0) {
                    if (p0 != null && p0.length < 10 || p0 == null) {
                      return 'Fullname must be at least 10 characters';
                    }
                    return null;
                  },
                  controller: viewModel.fullnameController..text = userService.userModel?.userDataModel.fullname ?? '',
                  hintText: 'Fullname',
                ),
                SizedBox(height: context.normalValue),
                CustomTextFormFieldWidget(
                  validator: (p0) {
                    if (p0 != null && p0.length < 3 || p0 == null) {
                      return 'Username must be at least 3 characters';
                    }
                    return null;
                  },
                  controller: viewModel.usernameController..text = userService.userModel?.userDataModel.username ?? '',
                  hintText: 'Username',
                ),
                SizedBox(height: context.normalValue),
                SizedBox(
                  height: 36 * 3,
                  child: CustomTextFieldWidget(
                    controller: viewModel.bioController..text = userService.userModel?.userDataModel.bio ?? '',
                    hintText: 'Add Bio',
                    maxLines: 4,
                    maxLength: 300,
                    expands: true,
                    textInputType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                  ),
                ),
                SizedBox(height: context.normalValue),
                CustomTextFieldWidget(
                  readOnly: true,
                  controller: viewModel.emailController..text = userService.userModel?.userDataModel.email ?? '',
                  hintText: 'Email',
                ),
                SizedBox(height: context.normalValue),
                CustomTextFieldWidget(
                  readOnly: true,
                  controller: viewModel.passwordController..text = '••••••••••',
                  hintText: '••••••••••',
                  isObscureText: context.select<EditProfileViewModel, bool>((value) => value.isObscure),
                  suffixIcon: GestureDetector(
                    onTap: viewModel.setObscureOrNot,
                    child: const Icon(CupertinoIcons.eye_fill, color: Colors.grey),
                  ),
                ),
                SizedBox(height: context.normalValue),
                CustomButtonWidget(
                  text: 'Update Profile',
                  onPressed: () async {
                    viewModel.formKey.currentState?.save();
                    final bool? isValid = viewModel.formKey.currentState?.validate();

                    if (isValid == true) {
                      await viewModel.uploadUser().then((value) {
                        viewModel.clearAll();
                        context.pop();
                      });
                    }
                  },
                  textColor: context.colors.onPrimary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
