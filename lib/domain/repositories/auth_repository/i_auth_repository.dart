import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_coding_setup/core/extensions/dartz_extension.dart';

abstract class IAuthRepository {
  Future<DataModel<UserCredential>> registerUser({
    required String email,
    required String password,
    required String username,
    required String fullname,
  });
  Future<DataModel<UserCredential>> loginUser({required String email, required String password});
  Future<DataModel<void>> signOut();
}
