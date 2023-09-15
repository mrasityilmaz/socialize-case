import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_coding_setup/data/models/user_models/user_data_model/user_data_model.dart';

extension UserDataModell on UserDataModel {
  UserDataModel get clearModel => UserDataModel(
        email: email ?? '',
        userId: userId ?? FirebaseAuth.instance.currentUser?.uid ?? '',
        fullname: fullname ?? FirebaseAuth.instance.currentUser?.displayName ?? '',
        username: username ?? FirebaseAuth.instance.currentUser?.displayName ?? '',
        profileImageUrl: profileImageUrl,
        bio: bio ?? '',
      );
}
