import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_coding_setup/core/errors/errors.dart';
import 'package:my_coding_setup/core/mixin/viewmodel_mixins/viewmodel_helper_mixin.dart';
import 'package:my_coding_setup/core/services/permission_service.dart';
import 'package:my_coding_setup/data/models/post_model/post_model.dart';
import 'package:my_coding_setup/domain/repositories/post_repository/i_post_repository.dart';
import 'package:my_coding_setup/injection/injection_container.dart';

final class CreatePostViewModel extends ChangeNotifier with BusyAndErrorStateHelper {
  CreatePostViewModel() {
    setInitialised(true);
  }

  final TextEditingController _descController = TextEditingController();

  final IPostRepository _postRepository = locator<IPostRepository>();

  final ImagePicker _picker = ImagePicker();

  File? _postPhoto;

  File? get postPhoto => _postPhoto;
  TextEditingController get descController => _descController;

  Future<void> pickProfilePhoto() async {
    final File? image = await runBusyFuture(_getImage());

    if (image != null) {
      _postPhoto = image;

      notifyListeners();
    } else {
      print('image is null');
    }
  }

  Future<Either<Failure, PostModel>> createPost() async {
    if (_postPhoto != null) {
      final result = await runBusyFuture(_postRepository.createPost(image: _postPhoto!, caption: _descController.text.trim())).then((value) => value);

      return result;
    }

    return Left(ServerFailure(errorMessage: 'Please select a photo'));
  }

  void clearAll() {
    _postPhoto = null;
    _descController.clear();
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
}
