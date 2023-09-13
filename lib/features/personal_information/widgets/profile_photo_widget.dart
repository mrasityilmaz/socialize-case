part of '../personal_information_view.dart';

final class _ProfilePhotoWidget extends StatelessWidget {
  const _ProfilePhotoWidget();

  @override
  Widget build(BuildContext context) {
    final PersonalInformationViewModel viewModel = context.read<PersonalInformationViewModel>();
    final File? photo = context.select<PersonalInformationViewModel, File?>((value) => value.profilePhoto);
    final bool isBusy = context.select<PersonalInformationViewModel, bool>((value) => value.isBusy);
    return InkWell(
      borderRadius: context.borderRadiusNormal,
      onTap: () async => viewModel.pickProfilePhoto(),
      child: Container(
        width: context.mediaQuery.size.width * .25,
        height: context.mediaQuery.size.width * .25,
        decoration: BoxDecoration(
          border: photo == null ? null : Border.all(color: context.theme.primaryColor, width: 2),
          borderRadius: context.borderRadiusNormal,
          color: context.theme.primaryColor,
          image: photo != null ? DecorationImage(image: MemoryImage(photo.readAsBytesSync()), fit: BoxFit.cover) : null,
        ),
        child: photo != null ? null : (isBusy ? const CircularProgressIndicator.adaptive() : Icon(Icons.add, color: context.colors.background)),
      ),
    );
  }
}
