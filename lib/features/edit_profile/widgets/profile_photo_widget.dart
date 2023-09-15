part of '../edit_profile_view.dart';

final class _ProfilePhotoWidget extends StatelessWidget {
  const _ProfilePhotoWidget();

  @override
  Widget build(BuildContext context) {
    final File? photo = context.select<EditProfileViewModel, File?>((value) => value.profilePhoto);
    final bool isBusy = context.select<EditProfileViewModel, bool>((value) => value.isBusy);
    final String? oldPhoto = context.read<UserService>().userModel?.userDataModel.profileImageUrl ?? FirebaseAuth.instance.currentUser?.photoURL;
    final EditProfileViewModel viewModel = context.read<EditProfileViewModel>();
    return Center(
      child: InkWell(
        borderRadius: context.borderRadiusNormal,
        onTap: () async => viewModel.pickProfilePhoto(),
        child: Container(
          width: context.mediaQuery.size.width * .25,
          height: context.mediaQuery.size.width * .25,
          decoration: BoxDecoration(
            border: photo == null ? null : Border.all(color: context.theme.primaryColor, width: 2),
            borderRadius: context.borderRadiusNormal,
            color: context.theme.primaryColor,
            image: photo != null
                ? DecorationImage(image: MemoryImage(photo.readAsBytesSync()), fit: BoxFit.cover)
                : oldPhoto != null
                    ? DecorationImage(image: NetworkImage(oldPhoto), fit: BoxFit.cover)
                    : null,
          ),
          child: (photo != null || oldPhoto != null) ? null : (isBusy ? const CircularProgressIndicator.adaptive() : Icon(Icons.add, color: context.colors.background)),
        ),
      ),
    );
  }
}
