import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_coding_setup/core/mixin/viewmodel_mixins/viewmodel_helper_mixin.dart';
import 'package:my_coding_setup/data/models/user_models/user_data_model/user_data_model.dart';
import 'package:my_coding_setup/domain/repositories/user_repository/i_auth_repository.dart';
import 'package:my_coding_setup/injection/injection_container.dart';

final class PersonalInformationViewModel extends ChangeNotifier with BusyAndErrorStateHelper {
  PersonalInformationViewModel() {
    setInitialised(true);
  }

  final TextEditingController _bioController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  final IUserRepository _userRepository = locator<IUserRepository>();

  File? _profilePhoto;

  File? get profilePhoto => _profilePhoto;
  TextEditingController get bioController => _bioController;

  Future<void> pickProfilePhoto() async {
    final File? image = await runBusyFuture(_getImage());

    if (image != null) {
      _profilePhoto = image;

      notifyListeners();
    }
  }

  Future<void> uploadAndNext() async {
    if (_profilePhoto != null) {
      await runBusyFuture(
        Future.wait([
          _userRepository.uploadProfilePhoto(image: _profilePhoto!),
          if (_bioController.text.trim().isNotEmpty) ...[_userRepository.updateProfileData(model: const UserDataModel().copyWith(bio: _bioController.text.trim()))],
        ]),
      );
    }
  }

  ///
  /// Pick and return File object
  ///
  Future<File?> _getImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      return File(image.path);
    }
    return null;
  }
}
