import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_coding_setup/core/enums/custom_text_style_enum/text_style_enum.dart';
import 'package:my_coding_setup/core/extensions/context_extension.dart';
import 'package:my_coding_setup/core/mixin/post_functions_mixin/post_mixin.dart';
import 'package:my_coding_setup/core/services/like_service.dart';
import 'package:my_coding_setup/core/services/saved_post_service.dart';
import 'package:my_coding_setup/data/models/post_model/post_model.dart';
import 'package:my_coding_setup/features/components/widgets/text/custom_text_widget.dart';
import 'package:provider/provider.dart';

part 'bottom_row_section.dart';
part 'bottom_section.dart';
part 'photo_section.dart';
part 'user_section.dart';

class PostWidget extends StatelessWidget {
  const PostWidget({
    required this.postModel,
    super.key,
    this.onRemove,
    this.onSave,
  });
  final void Function()? onRemove;
  final void Function()? onSave;

  final PostModel postModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: context.paddingNormalHorizontal * .5 + context.paddingLowBottom,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 2),
        color: context.colors.onBackground.withOpacity(.02),
        borderRadius: context.borderRadiusLow,
      ),
      padding: context.paddingLow,
      child: Column(
        children: [
          _UsernameSection(postModel),
          const SizedBox(height: 8),
          _PhotoSection(postModel),
          const SizedBox(height: 10),
          _ButtonRowSection(
            postModel,
            onRemove,
            onSave,
          ),
          const SizedBox(height: 6),
          _BottomSection(postModel),
        ],
      ),
    );
  }
}
