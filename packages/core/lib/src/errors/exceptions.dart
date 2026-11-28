class AppException implements Exception {
  const AppException({required this.message});

  final String message;

  @override
  String toString() => 'AppException(message: $message)';
}

class AuthenticationException extends AppException {
  const AuthenticationException({required super.message});
}

class DatabaseException extends AppException {
  const DatabaseException({required super.message});
}

class PermissionException extends AppException {
  const PermissionException({required super.message});
}

class NotFoundException extends AppException {
  const NotFoundException({required super.message});
}

class StorageException extends AppException {
  const StorageException({required super.message});
}

class StorageServerException extends AppException {
  const StorageServerException({required super.message});
}

class NetworkException extends AppException {
  const NetworkException({
    super.message =
        'Network connection failed. '
        'Please check your internet connection',
  });
}

class UnknownException extends AppException {
  const UnknownException({super.message = 'An unkown error has occured.'});
}
