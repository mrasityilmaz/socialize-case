part of '../create_post_view.dart';

final class _PostPhotoWidget extends StatelessWidget {
  const _PostPhotoWidget();

  @override
  Widget build(BuildContext context) {
    final CreatePostViewModel viewModel = context.read<CreatePostViewModel>();
    final File? photo = context.select<CreatePostViewModel, File?>((value) => value.postPhoto);
    final bool isBusy = context.select<CreatePostViewModel, bool>((value) => value.isBusy);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          borderRadius: context.borderRadiusNormal,
          onTap: () async => viewModel.pickProfilePhoto(),
          child: Container(
            width: context.mediaQuery.size.width * .6,
            height: context.mediaQuery.size.width * .6,
            decoration: BoxDecoration(
              border: photo == null ? null : Border.all(color: context.theme.primaryColor, width: 2),
              borderRadius: context.borderRadiusNormal,
              color: context.theme.primaryColor.withOpacity(.3),
              image: photo != null ? DecorationImage(image: MemoryImage(photo.readAsBytesSync()), fit: BoxFit.cover) : null,
            ),
            child: photo != null ? null : (isBusy ? const CircularProgressIndicator.adaptive() : Icon(Icons.add, color: context.colors.background)),
          ),
        ),
        SizedBox(height: context.lowValue),
        const CustomTextWidget(
          text: 'Add Photo',
        ),
      ],
    );
  }
}
