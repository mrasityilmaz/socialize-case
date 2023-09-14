import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_coding_setup/core/extensions/dartz_extension.dart';
import 'package:my_coding_setup/core/mixin/viewmodel_mixins/viewmodel_helper_mixin.dart';
import 'package:my_coding_setup/domain/repositories/auth_repository/i_auth_repository.dart';
import 'package:my_coding_setup/injection/injection_container.dart';

final class SignInViewModel extends ChangeNotifier with BusyAndErrorStateHelper {
  SignInViewModel() {
    setInitialised(true);
  }

  ///
  /// Repositories
  ///
  final IAuthRepository _authRepository = locator<IAuthRepository>();

  ///
  /// Controllers
  ///
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  ///
  /// Properties
  ///
  bool _isObscure = true;

  ///
  ///  Getter of Properties
  ///
  bool get isObscure => _isObscure;

  ///
  /// Setter of Properties
  ///
  void setObscureOrNot() {
    _isObscure = !_isObscure;
    notifyListeners();
  }

  void clearAll() {
    emailController.clear();
    passwordController.clear();
  }

  ///
  /// Methods
  ///

  Future<DataModel<UserCredential>> login() async {
    final result = await runBusyFuture(
      Future.delayed(
        const Duration(seconds: 2),
        () async {
          return _authRepository.loginUser(email: emailController.text.trim(), password: passwordController.text.trim());
        },
      ),
    );

    return result;
  }
}
