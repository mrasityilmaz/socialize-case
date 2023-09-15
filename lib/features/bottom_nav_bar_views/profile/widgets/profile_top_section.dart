import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_coding_setup/core/enums/custom_text_style_enum/text_style_enum.dart';
import 'package:my_coding_setup/core/enums/routes/routes_enum.dart';
import 'package:my_coding_setup/core/extensions/context_extension.dart';
import 'package:my_coding_setup/data/models/user_models/user_data_model/user_data_model.dart';
import 'package:my_coding_setup/features/components/widgets/buttons/custom_button.dart';
import 'package:my_coding_setup/features/components/widgets/text/custom_text_widget.dart';

class ProfileTopSection extends StatelessWidget {
  const ProfileTopSection({required this.userDataModel, super.key});
  final UserDataModel userDataModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 4,
          child: LayoutBuilder(
            builder: (context, constraints) => Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: context.borderRadiusLow,
                  child: Image.network(
                    userDataModel.profileImageUrl,
                    height: constraints.maxHeight,
                    width: constraints.maxHeight,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  const Expanded(
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: CustomTextWidget(text: 'Followers', style: CustomTextStyleEnum.s15w600),
                                    ),
                                  ),
                                  Expanded(
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: CustomTextWidget(text: '${userDataModel.followersCount ?? 0}'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  const Expanded(
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: CustomTextWidget(text: 'Following', style: CustomTextStyleEnum.s15w600),
                                    ),
                                  ),
                                  Expanded(
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: CustomTextWidget(text: '${userDataModel.followingCount ?? 0}'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: context.paddingNormalHorizontal,
                        child: CustomButtonWidget(
                          text: 'Edit Profile',
                          size: const Size.fromHeight(kMinInteractiveDimension * .6),
                          textStyle: CustomTextStyleEnum.s14w600,
                          onPressed: () {
                            context.pushNamed(RouteNames.editProfile.name);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        Align(
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextWidget(
                text: userDataModel.fullname ?? FirebaseAuth.instance.currentUser?.displayName ?? 'Unknown User',
                style: CustomTextStyleEnum.s17w500,
              ),
              CustomTextWidget(
                text: '@${userDataModel.username ?? FirebaseAuth.instance.currentUser?.displayName ?? '@username'}',
                textColor: context.colors.onBackground.withOpacity(.5),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Align(
          alignment: Alignment.centerLeft,
          child: CustomTextWidget(
            text: userDataModel.bio ?? '',
            textColor: context.colors.onBackground.withOpacity(.5),
            maxLines: 2,
          ),
        ),
        Divider(color: context.colors.onBackground.withOpacity(.2)),
      ],
    );
  }
}
