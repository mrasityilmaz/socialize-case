part of 'post_widget.dart';

class _PhotoSection extends StatelessWidget with PostMixin {
  const _PhotoSection(this.postModel);
  final PostModel postModel;

  @override
  Widget build(BuildContext context) {
    final bool isLiked = context.select<LikeService, bool>((value) => value.isLiked(postModel.id));
    return AspectRatio(
      aspectRatio: 1.2,
      child: GestureDetector(
        onDoubleTap: () async => likeOrDislikeFunction(isLiked: isLiked, postId: postModel.id),
        child: ClipRRect(
          borderRadius: context.borderRadiusLow,
          child: Image.network(
            postModel.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
