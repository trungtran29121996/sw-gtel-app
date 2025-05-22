class RequestException implements Exception {
  final String message;
  final String prefix;

  RequestException({required this.message, required this.prefix});

  @override
  String toString() {
    return "$prefix$message";
  }
}

class FetchDataException extends RequestException {
  FetchDataException(String message)
      : super(message: message, prefix: "Error During Communication: ");
}

class BadRequestException extends RequestException {
  BadRequestException(message)
      : super(message: message, prefix: "Invalid Request: ");
}

class UnauthorizedException extends RequestException {
  UnauthorizedException(message)
      : super(message: message, prefix: "Unauthorised: ");
}

class InvalidInputException extends RequestException {
  InvalidInputException(message)
      : super(message: message, prefix: "Invalid Input: ");
}
