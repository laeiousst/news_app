abstract class AppException implements Exception {
  const AppException();
}

class UnknownException extends AppException {}

class LimitReachedException extends AppException {}
