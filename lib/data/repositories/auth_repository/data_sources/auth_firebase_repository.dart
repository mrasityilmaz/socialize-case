import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:my_coding_setup/core/errors/errors.dart';
import 'package:my_coding_setup/core/extensions/dartz_extension.dart';
import 'package:my_coding_setup/domain/repositories/auth_repository/data_sources/iremote_repository.dart';

@Environment('real')
@LazySingleton(as: IAuthRemoteRepository)
class AuthFirebaseRepository implements IAuthRemoteRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<DataModel<UserCredential>> registerUser({
    required String email,
    required String password,
    required String username,
    required String fullname,
  }) async {
    try {
      final registerResult = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);

      return Right(registerResult);
    } on FirebaseAuthException catch (e) {
      String errorMessage = e.message ?? 'Something went wrong';
      if (e.code == 'weak-password') {
        errorMessage = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'The account already exists for that email.';
      }

      return Left(
        FirebaseAuthFailure(
          errorMessage: errorMessage,
        ),
      );
    } catch (e) {
      return Left(UnExpectedFailure(data: e));
    }
  }

  @override
  Future<DataModel<UserCredential>> loginUser({required String email, required String password}) async {
    try {
      final registerResult = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);

      return Right(registerResult);
    } on FirebaseAuthException catch (e) {
      String errorMessage = e.message ?? 'Something went wrong';

      if (e.code == 'user-not-found') {
        errorMessage = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Wrong password provided for that user.';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'Invalid email provided.';
      }

      return Left(
        FirebaseAuthFailure(
          errorMessage: errorMessage,
        ),
      );
    } catch (e) {
      return Left(UnExpectedFailure(data: e));
    }
  }

  @override
  Future<DataModel<void>> signOut() async {
    try {
      final registerResult = await _firebaseAuth.signOut();

      return Right(registerResult);
    } on FirebaseAuthException catch (e) {
      final String errorMessage = e.message ?? 'Something went wrong';

      return Left(
        FirebaseAuthFailure(
          errorMessage: errorMessage,
        ),
      );
    } catch (e) {
      return Left(UnExpectedFailure(data: e));
    }
  }
}
