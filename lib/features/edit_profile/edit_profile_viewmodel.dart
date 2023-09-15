import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_coding_setup/core/mixin/viewmodel_mixins/viewmodel_helper_mixin.dart';
import 'package:my_coding_setup/core/services/permission_service.dart';
import 'package:my_coding_setup/data/models/user_models/user_data_model/user_data_model.dart';
import 'package:my_coding_setup/domain/repositories/user_repository/i_auth_repository.dart';
import 'package:my_coding_setup/injection/injection_container.dart';

final class EditProfileViewModel extends ChangeNotifier with BusyAndErrorStateHelper {
  EditProfileViewModel() {
    setInitialised(true);
  }

  ///
  /// Repositories
  ///

  final IUserRepository _userRepository = locator<IUserRepository>();

  ///
  /// Controllers
  ///
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();

  ///
  /// Properties
  ///
  bool _isObscure = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final ImagePicker _picker = ImagePicker();

  File? _profilePhoto;

  File? get profilePhoto => _profilePhoto;

  ///
  ///  Getter of Properties
  ///
  bool get isObscure => _isObscure;
  GlobalKey<FormState> get formKey => _formKey;

  ///
  /// Setter of Properties
  ///
  void setObscureOrNot() {
    _isObscure = !_isObscure;
    notifyListeners();
  }

  void clearAll() {
    emailController.clear();
    passwordController.clear();
    fullnameController.clear();
    usernameController.clear();
    bioController.clear();
    _profilePhoto = null;
  }

  Future<void> pickProfilePhoto() async {
    final File? image = await runBusyFuture(_getImage());

    if (image != null) {
      _profilePhoto = image;

      notifyListeners();
    }
  }

  Future<void> uploadUser() async {
    await runBusyFuture(
      Future.wait([
        if (_profilePhoto != null) ...[
          _userRepository.uploadProfilePhoto(image: _profilePhoto!),
        ],
        _userRepository.updateProfileData(model: const UserDataModel().copyWith(bio: bioController.text.trim(), fullname: fullnameController.text.trim(), username: usernameController.text.trim())),
      ]),
    );
  }

  ///
  /// Pick and return File object
  ///
  Future<File?> _getImage() async {
    final bool? isPermissionGranted = await PermissionService.instance.checkGalleryPermission();

    if (isPermissionGranted == true) {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        return File(image.path);
      }
      return null;
    } else {
      return null;
    }
  }

  ///
  /// Methods
  ///

//   Future<bool> registerUser() async {
//     final result = await runBusyFuture(
//       _authRepository.registerUser(
//         email: emailController.text.trim(),
//         password: passwordController.text.trim(),
//         username: usernameController.text.trim(),
//         fullname: fullnameController.text.trim(),
//       ),
//     );

//     if (result.isRight()) {
//       return true;
//     } else {
//       debugPrint(result.asLeft().toString());
//       return false;
//     }
//   }
}
