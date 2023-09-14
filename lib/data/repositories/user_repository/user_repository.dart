import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:my_coding_setup/core/errors/errors.dart';
import 'package:my_coding_setup/core/extensions/dartz_extension.dart';
import 'package:my_coding_setup/core/platform/network_info.dart';
import 'package:my_coding_setup/data/models/user_models/user_data_model/user_data_model.dart';
import 'package:my_coding_setup/data/models/user_models/user_model/user_model.dart';
import 'package:my_coding_setup/domain/repositories/user_repository/data_sources/ilocal_repository.dart';
import 'package:my_coding_setup/domain/repositories/user_repository/data_sources/iremote_repository.dart';
import 'package:my_coding_setup/domain/repositories/user_repository/i_auth_repository.dart';

@LazySingleton(as: IUserRepository)
class UserRepository implements IUserRepository {
  const UserRepository({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });
  final IUserRemoteRepository remoteDataSource;
  final IUserLocalRepository localDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<DataModel<String>> uploadProfilePhoto({required File image}) async {
    if (await networkInfo.isConnected) {
      final result = await remoteDataSource.uploadProfilePhoto(image: image);

      if (result.isRight() && FirebaseAuth.instance.currentUser?.uid != null) {
        await remoteDataSource.updateProfileData(
          model: UserDataModel(
            profileImageUrl: result.asRight(),
          ),
        );
      }

      return result;
    } else {
      ///
      /// I dont have local data source so I will return other options
      ///
      return Left(NetworkFailure());
    }
  }

  @override
  Future<DataModel<UserModel>> updateProfileData({required UserDataModel model}) async {
    if (await networkInfo.isConnected) {
      final result = await remoteDataSource.updateProfileData(model: model);

      return result;
    } else {
      ///
      /// I dont have local data source so I will return other options
      ///
      return Left(NetworkFailure());
    }
  }

  @override
  Future<DataModel<UserModel>> getUserProfile() async {
    if (await networkInfo.isConnected) {
      final result = await remoteDataSource.getUserProfile();

      return result;
    } else {
      ///
      /// I dont have local data source so I will return other options
      ///
      return Left(NetworkFailure());
    }
  }

  @override
  Future<DataModel<List<UserDataModel>>> searchUsers({required String query}) async {
    if (await networkInfo.isConnected) {
      final result = await remoteDataSource.searchUsers(query: query);

      return result;
    } else {
      ///
      /// I dont have local data source so I will return other options
      ///
      return Left(NetworkFailure());
    }
  }
}
