import 'package:news_application_2/utils/enums.dart';

class ValidationRules {
  static String? validate(ValidationType type, String? value) {
    switch (type) {
      case ValidationType.username:
        return _validateUsername(value);
      case ValidationType.email:
        return _validateEmail(value);
      case ValidationType.phoneNo:
        return _validatePhoneNo(value);
    }
  }

  static String? _validateUsername(String? value) {
    if (value == null || value.isEmpty) return 'Username cannot be empty';
    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
      return 'Username can only contain letters and spaces';
    }
    if (value.trim().length < 3 || value.trim().length > 15) {
      return 'Username must be between 3-15 characters';
    }
    return null;
  }

  static String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Email cannot be empty';
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Invalid email address';
    }
    return null;
  }

  static String? _validatePhoneNo(String? value) {
    if (value == null || value.isEmpty) return 'Phone number cannot be empty';
    if (!RegExp(r'^\d{10,13}$').hasMatch(value)) return 'Invalid phone number';
    return null;
  }
}
