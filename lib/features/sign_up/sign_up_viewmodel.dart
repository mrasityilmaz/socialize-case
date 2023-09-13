import 'package:flutter/material.dart';
import 'package:my_coding_setup/core/extensions/dartz_extension.dart';
import 'package:my_coding_setup/core/mixin/viewmodel_mixins/viewmodel_helper_mixin.dart';
import 'package:my_coding_setup/domain/repositories/auth_repository/i_auth_repository.dart';
import 'package:my_coding_setup/injection/injection_container.dart';

final class SignUpViewModel extends ChangeNotifier with BusyAndErrorStateHelper {
  SignUpViewModel() {
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
  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  ///
  /// Properties
  ///
  bool _isObscure = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  ///
  ///  Getter of Properties
  ///
  bool get isObscure => _isObscure;
  GlobalKey<FormState> get formKey => _formKey;

  ///
  /// Setter of Properties
  ///
  void setObscureOrNot() {
    _isObscure = !_isObscure;
    notifyListeners();
  }

  ///
  /// Methods
  ///

  Future<bool> registerUser() async {
    final result = await runBusyFuture(
      _authRepository.registerUser(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        username: usernameController.text.trim(),
        fullname: fullnameController.text.trim(),
      ),
    );

    if (result.isRight()) {
      return true;
    } else {
      debugPrint(result.asLeft().toString());
      return false;
    }
  }
}
