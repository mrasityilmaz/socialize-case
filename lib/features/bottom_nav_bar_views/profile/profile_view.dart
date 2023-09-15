import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_coding_setup/core/enums/custom_text_style_enum/text_style_enum.dart';
import 'package:my_coding_setup/core/extensions/context_extension.dart';
import 'package:my_coding_setup/core/extensions/userdata_model_extension.dart';
import 'package:my_coding_setup/core/services/user_service.dart';
import 'package:my_coding_setup/data/models/user_models/user_data_model/user_data_model.dart';
import 'package:my_coding_setup/features/bottom_nav_bar_views/profile/profile_viewmodel.dart';
import 'package:my_coding_setup/features/bottom_nav_bar_views/profile/widgets/profile_top_section.dart';
import 'package:my_coding_setup/features/components/base_viewmodel_builder/base_viewmodel_builder.dart';
import 'package:my_coding_setup/features/components/widgets/text/custom_text_widget.dart';
import 'package:my_coding_setup/injection/injection_container.dart';
import 'package:provider/provider.dart';

final class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileViewModel viewModel = context.watch<ProfileViewModel>();
    final UserService userService = context.watch<UserService>();
    return Scaffold(
      appBar: AppBar(
        title: CustomTextWidget(text: userService.userModel?.userDataModel.username ?? FirebaseAuth.instance.currentUser?.displayName ?? 'Username', style: CustomTextStyleEnum.s16w500),
        actions: [
          IconButton(
            onPressed: () async {
              await viewModel.runBusyFuture(locator<UserService>().logout(context));
            },
            icon: const Icon(Icons.logout, color: Colors.red),
          ),
        ],
      ),
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: context.paddingNormalHorizontal,
          child: CustomViewModelBuilder<ProfileViewModel>(
            onViewModelReady: () async {
              await viewModel.getMyPosts();
            },
            child: Column(
              children: [
                ProfileTopSection(
                  userDataModel: userService.userModel?.userDataModel.clearModel ?? const UserDataModel(),
                ),
                Expanded(
                  child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, crossAxisSpacing: 2, mainAxisSpacing: 2),
                    itemCount: viewModel.posts.length,
                    itemBuilder: (context, index) {
                      return Image.network(
                        viewModel.posts[index].imageUrl,
                        fit: BoxFit.cover,
                      );
                    },
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
