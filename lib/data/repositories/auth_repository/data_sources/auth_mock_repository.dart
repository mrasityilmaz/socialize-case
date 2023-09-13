import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:my_coding_setup/core/extensions/dartz_extension.dart';
import 'package:my_coding_setup/domain/repositories/auth_repository/data_sources/iremote_repository.dart';

@Environment('mock')
@LazySingleton(as: IAuthRemoteRepository)
class AuthMockRepository implements IAuthRemoteRepository {
  @override
  Future<DataModel<UserCredential>> registerUser({
    required String email,
    required String password,
    required String username,
    required String fullname,
  }) {
    // TODO: implement registerUser
    throw UnimplementedError();
  }

  @override
  Future<DataModel<UserCredential>> loginUser({required String email, required String password}) {
    // TODO: implement loginUser
    throw UnimplementedError();
  }

  @override
  Future<DataModel<void>> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }
}
