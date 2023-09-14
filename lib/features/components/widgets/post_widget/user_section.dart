part of 'post_widget.dart';

final class _UsernameSection extends StatelessWidget {
  const _UsernameSection(this.postModel);
  final PostModel postModel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kMinInteractiveDimension * .7,
      child: LayoutBuilder(
        builder: (context, constraints) => Row(
          children: [
            SizedBox(
              height: constraints.maxHeight,
              width: constraints.maxHeight,
              child: ClipRRect(
                borderRadius: context.borderRadiusLow,
                child: Image.network(
                  postModel.userImageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 8),
            CustomTextWidget(
              text: postModel.userName,
              style: CustomTextStyleEnum.s16w600,
            ),
            const Spacer(),
            const Icon(Icons.more_horiz_rounded),
          ],
        ),
      ),
    );
  }
}
