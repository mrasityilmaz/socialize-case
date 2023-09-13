import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:my_coding_setup/core/constants/firebase_constants.dart';
import 'package:my_coding_setup/core/errors/errors.dart';
import 'package:my_coding_setup/core/extensions/dartz_extension.dart';
import 'package:my_coding_setup/data/models/user_models/user_data_model/user_data_model.dart';
import 'package:my_coding_setup/data/models/user_models/user_model/user_model.dart';
import 'package:my_coding_setup/domain/repositories/user_repository/data_sources/iremote_repository.dart';

@Environment('real')
@LazySingleton(as: IUserRemoteRepository)
class UserFirebaseRepository implements IUserRemoteRepository {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final CollectionReference<Map<String, dynamic>> _userCollection = FirebaseConstants.instance.userCollection;

  @override
  Future<DataModel<String>> uploadProfilePhoto({required File image}) async {
    try {
      return await _firebaseStorage.ref('${FirebaseAuth.instance.currentUser?.uid}').child('profile_photo').putFile(image).then((p0) async {
        final String downloadUrl = await p0.ref.getDownloadURL();
        debugPrint(downloadUrl);

        return Right(downloadUrl);
      });
    } catch (e) {
      return Left(ServerFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<DataModel<UserModel>> updateProfileData({required UserDataModel model}) async {
    try {
      await _userCollection.doc(FirebaseAuth.instance.currentUser?.uid).set(
        {
          'userDataModel': model.toJson()..removeWhere((key, value) => value == null),
          'updatedAt': DateTime.now().toUtc(),
        },
        SetOptions(merge: true),
      );
      return Right(UserModel(userDataModel: model, createdAt: DateTime.now().toUtc(), updatedAt: DateTime.now().toUtc()));
    } catch (e) {
      return Left(ServerFailure(errorMessage: e.toString()));
    }
  }
}
