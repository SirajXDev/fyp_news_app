class NewsFieldValidator {
  static String? validate({
    required String? value,
    String? invalidMessage,
    String? lengthMessage,
    int? minLength,
  }) {
    if (!RegExp(r'^[a-zA-Z0-9\s\.,!?-]+$').hasMatch(value!)) {
      return invalidMessage ?? 'Invalid input';
    } else if (value.trim().length < (minLength ?? 10)) {
      return lengthMessage ??
          'Input must be at least ${minLength ?? 10} characters';
    }
    return null;
  }
}

class NewsValidators {
  static String? titleValid(String? value) => NewsFieldValidator.validate(
        value: value,
        invalidMessage: 'Invalid title',
        lengthMessage: 'Title must be at least 3 characters',
        minLength: 3,
      );

  static String? descValid(String? value) => NewsFieldValidator.validate(
        value: value,
        invalidMessage: 'Invalid description',
        lengthMessage: 'Description must be at least 10 characters',
        minLength: 10,
      );

  static String? authorValid(String? value) => NewsFieldValidator.validate(
        value: value,
        invalidMessage: 'Invalid author',
        lengthMessage: 'Author name must be at least 3 characters',
        minLength: 3,
      );

  static String? sourceValid(String? value) => NewsFieldValidator.validate(
        value: value,
        invalidMessage: 'Invalid source',
        lengthMessage: 'Source name must be at least 3 characters',
        minLength: 3,
      );
}
