final class ValidatorService {
  factory ValidatorService() => instance;

  ValidatorService._internal();

  static final ValidatorService instance = ValidatorService._internal();

  bool emailValid(String? email) {
    if (email == null) {
      return false;
    } else {
      return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
    }
  }

  String? checkEmail(String? value) {
    if (value != null && value.trim().length > 3 || value == null) {
      if (value?.isNotEmpty == true && emailValid(value)) {
        return null;
      } else {
        return 'Please enter a valid email';
      }
    }
    return null;
  }

  String? checkPassword(String? value) {
    if (value?.isEmpty == true || (value?.length ?? 0) >= 6) {
      return null;
    } else {
      return 'Please enter a valid password';
    }
  }
}
