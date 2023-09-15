import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_coding_setup/core/enums/custom_text_style_enum/text_style_enum.dart';
import 'package:my_coding_setup/core/extensions/context_extension.dart';
import 'package:my_coding_setup/core/extensions/dartz_extension.dart';
import 'package:my_coding_setup/features/bottom_nav_bar_views/create_post/create_post_viewmodel.dart';
import 'package:my_coding_setup/features/bottom_nav_bar_views/home/home_viewmodel.dart';
import 'package:my_coding_setup/features/bottom_nav_bar_views/profile/profile_viewmodel.dart';
import 'package:my_coding_setup/features/components/base_viewmodel_builder/base_viewmodel_builder.dart';
import 'package:my_coding_setup/features/components/widgets/buttons/custom_button.dart';
import 'package:my_coding_setup/features/components/widgets/text/custom_text_widget.dart';
import 'package:my_coding_setup/features/components/widgets/text_field/text_field.dart';
import 'package:provider/provider.dart';

part 'widgets/post_photo_widget.dart';

final class CreatePostView extends StatelessWidget {
  const CreatePostView({super.key});

  @override
  Widget build(BuildContext context) {
    final CreatePostViewModel viewModel = context.read<CreatePostViewModel>();
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: context.colors.onBackground,
          onPressed: () {
            viewModel.clearAll();
            context.pop();
          },
        ),
        title: const CustomTextWidget(
          text: 'Create Post',
          style: CustomTextStyleEnum.s18w600,
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: context.paddingNormal,
          child: CustomButtonWidget(
            text: 'Share',
            onPressed: context.select<CreatePostViewModel, bool>((value) => value.postPhoto != null)
                ? () async {
                    await viewModel.createPost().then((value) {
                      if (value.isRight()) {
                        debugPrint('Post created');
                        context.read<HomeViewModel>().addNewPost(value.asRight());
                        context.read<ProfileViewModel>().addPostToList(value.asRight());
                        viewModel.clearAll();
                        context.pop();
                      } else {
                        debugPrint('Post not created ${value.asLeft()}');
                      }
                    });
                  }
                : null,
          ),
        ),
      ),
      body: CustomViewModelBuilder<CreatePostViewModel>(
        child: SafeArea(
          child: Padding(
            padding: context.paddingNormalHorizontal * 1.5,
            child: ListView(
              physics: const ClampingScrollPhysics(),
              children: [
                const Center(child: _PostPhotoWidget()),
                SizedBox(height: context.normalValue),
                const CustomTextWidget(
                  text: 'Description (Optional)',
                  style: CustomTextStyleEnum.s16w500,
                ),
                SizedBox(height: context.lowValue),
                SizedBox(
                  height: 36 * 3,
                  child: CustomTextFieldWidget(
                    controller: viewModel.descController,
                    hintText: 'Add Description',
                    maxLines: 3,
                    maxLength: 140,
                    expands: true,
                    textInputType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
