import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:my_coding_setup/core/constants/firebase_constants.dart';
import 'package:my_coding_setup/core/errors/errors.dart';
import 'package:my_coding_setup/core/extensions/dartz_extension.dart';
import 'package:my_coding_setup/core/platform/network_info.dart';
import 'package:my_coding_setup/core/services/user_service.dart';
import 'package:my_coding_setup/core/utils/string_to_search_options.dart';
import 'package:my_coding_setup/data/models/user_models/user_data_model/user_data_model.dart';
import 'package:my_coding_setup/data/models/user_models/user_model/user_model.dart';
import 'package:my_coding_setup/domain/repositories/auth_repository/data_sources/ilocal_repository.dart';
import 'package:my_coding_setup/domain/repositories/auth_repository/data_sources/iremote_repository.dart';
import 'package:my_coding_setup/domain/repositories/auth_repository/i_auth_repository.dart';
import 'package:my_coding_setup/domain/repositories/user_repository/i_auth_repository.dart';
import 'package:my_coding_setup/injection/injection_container.dart';

@LazySingleton(as: IAuthRepository)
class AuthRepository implements IAuthRepository {
  const AuthRepository({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });
  final IAuthRemoteRepository remoteDataSource;
  final IAuthLocalRepository localDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<DataModel<UserCredential>> registerUser({
    required String email,
    required String password,
    required String username,
    required String fullname,
  }) async {
    if (await networkInfo.isConnected) {
      final result = await remoteDataSource.registerUser(email: email, password: password, username: username, fullname: fullname);

      ///
      /// Setting up user data in firestore when user is registered successfully
      ///
      if (result.isRight() && result.asRight().user?.uid != null) {
        try {
          await FirebaseConstants.instance.userCollection.doc(result.asRight().user!.uid).set(
                UserModel(
                  searchOptions: [...StringToSearchOptions.instance.convert(username), ...StringToSearchOptions.instance.convert(fullname)],
                  userDataModel: UserDataModel(
                    bio: '',
                    email: email,
                    fullname: fullname,
                    userId: result.asRight().user!.uid,
                    username: username,
                  ),
                  createdAt: DateTime.now().toUtc(),
                  updatedAt: DateTime.now().toUtc(),
                ).toJson(),
              );
        } catch (e) {
          debugPrint(e.toString());
        }
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
  Future<DataModel<UserCredential>> loginUser({required String email, required String password}) async {
    if (await networkInfo.isConnected) {
      final result = await remoteDataSource.loginUser(email: email, password: password);
      if (result.isRight()) {
        await locator<IUserRepository>().getUserProfile().then((value) async {
          if (value.isRight()) {
            locator<UserService>().setUserModel(value.asRight());
            await FirebaseAuth.instance.currentUser?.updatePhotoURL(value.asRight().userDataModel.profileImageUrl);
          }
        });
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
  Future<DataModel<void>> signOut() async {
    if (await networkInfo.isConnected) {
      return await remoteDataSource.signOut();
    } else {
      ///
      /// I dont have local data source so I will return other options
      ///
      return Left(NetworkFailure());
    }
  }
}
