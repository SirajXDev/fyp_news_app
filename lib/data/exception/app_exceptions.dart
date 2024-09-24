// ignore_for_file: prefer_typing_uninitialized_variables

class AppException implements Exception {
  final _message; // Message associated with the exception
  final _prefix; // Prefix for the exception

  AppException([this._message, this._prefix]);

  @override
  String toString() {
    return '$_message$_prefix'; // Returns the formatted error message
  }
}

/// Exception class representing a fetch data error during communication.
class FetchDataException extends AppException {
  FetchDataException([String? message])
      : super(message, 'Error During Communication');
}

/// Exception class representing a bad request error.
class BadRequestException extends AppException {
  BadRequestException([String? message]) : super(message, 'Invalid request');
}

/// Exception class representing an unauthorized request error.
class UnauthorisedException extends AppException {
  UnauthorisedException([String? message])
      : super(message, 'Unauthorised request');
}

/// Exception class representing an invalid input error.
class InvalidInputException extends AppException {
  InvalidInputException([String? message]) : super(message, 'Invalid Input');
}

/// Exception class representing a no internet connection error.
class NoInternetException extends AppException {
  NoInternetException([String? message])
      : super(message, 'No Internet Connection');
}
