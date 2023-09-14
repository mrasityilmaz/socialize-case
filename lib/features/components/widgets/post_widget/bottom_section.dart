part of 'post_widget.dart';

class _BottomSection extends StatelessWidget {
  const _BottomSection(this.postModel);
  final PostModel postModel;

  @override
  Widget build(BuildContext context) {
    final int likesCount = context.select<LikeService, int>((value) => (postModel.likesCount ?? 0) + (value.isLiked(postModel.id) ? 1 : 0));
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Align(
            alignment: Alignment.centerLeft,
            child: CustomTextWidget(text: '$likesCount likes', style: CustomTextStyleEnum.s13w500),
          ),
        ),
        if (postModel.description?.isNotEmpty == true) ...[
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 2),
            child: Row(
              children: [
                Expanded(
                  child: CustomTextWidget(
                    maxLines: 2,
                    text: postModel.description ?? '',
                    style: CustomTextStyleEnum.s15w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
