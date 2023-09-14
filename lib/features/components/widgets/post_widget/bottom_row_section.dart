part of 'post_widget.dart';

final class _ButtonRowSection extends StatelessWidget with PostMixin {
  const _ButtonRowSection(this.postModel, this.onRemove, this.onSave);
  final PostModel postModel;
  final void Function()? onRemove;
  final void Function()? onSave;

  @override
  Widget build(BuildContext context) {
    final bool isLiked = context.select<LikeService, bool>((value) => value.isLiked(postModel.id));
    final bool isSaved = context.select<SavedPostService, bool>((value) => value.isSaved(postModel.id));
    return Row(
      children: [
        const SizedBox(width: 10),
        GestureDetector(
          onTap: () async {
            if (!isSaved && isLiked) {
              onRemove?.call();
            } else {
              onSave?.call();
            }

            await likeOrDislikeFunction(isLiked: isLiked, postId: postModel.id);
          },
          child: Icon(
            isLiked ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
            color: isLiked ? Colors.red.shade700 : context.colors.onBackground,
            size: 25,
          ),
        ),
        const SizedBox(width: 10),
        Icon(
          CupertinoIcons.chat_bubble,
          color: context.colors.onBackground,
          size: 24,
        ),
        const SizedBox(width: 10),
        Icon(
          CupertinoIcons.paperplane,
          color: context.colors.onBackground,
          size: 22,
        ),
        const Spacer(),
        GestureDetector(
          onTap: () async {
            if (isSaved && !isLiked) {
              onRemove?.call();
            } else {
              onSave?.call();
            }
            await saveOrUnSaveFunction(isSaved: isSaved, postId: postModel.id);
          },
          child: Icon(
            isSaved ? CupertinoIcons.bookmark_fill : CupertinoIcons.bookmark,
            color: context.colors.onBackground,
            size: 22,
          ),
        ),
        const SizedBox(width: 10),
      ],
    );
  }
}
