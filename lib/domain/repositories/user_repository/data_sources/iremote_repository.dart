import 'dart:io';

import 'package:my_coding_setup/core/extensions/dartz_extension.dart';
import 'package:my_coding_setup/data/models/user_models/user_data_model/user_data_model.dart';
import 'package:my_coding_setup/data/models/user_models/user_model/user_model.dart';

abstract class IUserRemoteRepository {
  Future<DataModel<String>> uploadProfilePhoto({required File image});

  Future<DataModel<UserModel>> updateProfileData({required UserDataModel model});
}
