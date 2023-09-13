import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:my_coding_setup/core/extensions/dartz_extension.dart';
import 'package:my_coding_setup/data/models/user_models/user_data_model/user_data_model.dart';
import 'package:my_coding_setup/data/models/user_models/user_model/user_model.dart';
import 'package:my_coding_setup/domain/repositories/user_repository/data_sources/iremote_repository.dart';

@Environment('mock')
@LazySingleton(as: IUserRemoteRepository)
class UserMockRepository implements IUserRemoteRepository {
  @override
  Future<DataModel<String>> uploadProfilePhoto({required File image}) {
    // TODO: implement uploadProfilePhoto
    throw UnimplementedError();
  }

  @override
  Future<DataModel<UserModel>> updateProfileData({required UserDataModel model}) {
    // TODO: implement uploadProfile
    throw UnimplementedError();
  }
}
