class APIExceptions implements Exception {
  final _message;
  final _prefix;

  APIExceptions([this._message, this._prefix]);

  String toString() {
    return '$_prefix $_message';
  }
}

class FetchDataException extends APIExceptions {
  FetchDataException(String message)
      : super(message, 'Error During Communicate');
}

class BadRequestException extends APIExceptions {
  BadRequestException(String message) : super(message, 'Invalid request');
}

class UnauthorisedException extends APIExceptions {
  UnauthorisedException(String message) : super(message, 'Unauthorised ');
}

class InvalidInputException extends APIExceptions {
  InvalidInputException(String message) : super(message, 'Invalid Input ');
}

class AuthorisedException extends APIExceptions {
  AuthorisedException(String message) : super(message, 'Authorised failed');
}
