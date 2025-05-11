const String kSomethingUnexpected =
    'Something unexpected happened. Please try again later.';
const String kDeivceExceptionMessage =
    'Device is offline. Please check your internet connection';

class ServerException implements Exception {
  const ServerException({
    this.message = kSomethingUnexpected,
    this.code = -1,
    this.exception = '',
  });

  final String message;
  final int code;
  final String exception;
}

class AuthException implements Exception {
  const AuthException({
    this.message = kSomethingUnexpected,
    this.code = -1,
    this.exception = '',
  });

  final String message;
  final int code;
  final String exception;
}

class CacheException implements Exception {
  const CacheException({
    this.message = kSomethingUnexpected,
    this.code = -1,
    this.exception = '',
  });

  final String message;
  final int code;
  final String exception;
}

class DeviceException implements Exception {
  const DeviceException({
    this.message = kSomethingUnexpected,
    this.code = -1,
    this.exception = '',
  });

  final String message;
  final int code;
  final String exception;
}

class HiveException implements Exception {
  const HiveException({
    this.message = 'Failed to save data',
    this.code = -1,
    this.exception = '',
  });

  final String message;
  final int code;
  final String exception;
}
