import 'package:my_coding_setup/core/services/validator_service.dart';

extension StringFormatCheckExtension on String? {
  bool get isEmail => ValidatorService.instance.emailValid(this);
}
