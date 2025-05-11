import 'package:equatable/equatable.dart';

/// A [Failure] Represents Exception
/// This Failure class is super class of all other failures
/// All of the other failures extends this Failure class for writing
/// abstract methods easier and generalizing return type
abstract class Failure extends Equatable {
  const Failure({
    required this.message,
    this.exception,
    this.code,
  }) : super();
  final String message;
  final String? exception;
  final int? code;

  @override
  List<Object?> get props => <Object?>[message, exception, code];
}

/// A [ServerFailure] represents error from the Server EndPoint
/// [message] contains the text to be shown in UI
/// [exception] contains the actual exception caught by
/// the program for debugging
/// [code] is an extra field for now for future uses
class ServerFailure extends Failure with EquatableMixin {
  const ServerFailure({
    required super.message,
    super.exception,
    super.code,
  });

  @override
  List<Object?> get props => <Object?>[message, exception, code];
}

/// A [AuthFailure] represents error while the auth process
/// [message] contains the text to be shown in UI
/// [exception] contains the actual exception caught by
/// the program for debugging
/// [code] is an extra field for now for future uses
class AuthFailure extends Failure with EquatableMixin {
  const AuthFailure({
    required super.message,
    super.exception,
    super.code,
  });

  @override
  List<Object?> get props => <Object?>[message, exception, code];
}

/// A [DeviceFailure] represents error while the interacting with device data,
/// eg. Location, Contacts, Internet Connectivity, etc.
/// [message] contains the text to be shown in UI
/// [exception] contains the actual exception caught by
/// the program for debugging
/// [code] is an extra field for now for future uses
class DeviceFailure extends Failure with EquatableMixin {
  const DeviceFailure({
    required super.message,
    super.exception,
    super.code,
  });

  @override
  List<Object?> get props => <Object?>[message, exception, code];
}

/// A [CacheFailure] represents error while interacting with
/// caches or data storage
/// [message] contains the text to be shown in UI
/// [exception] contains the actual exception caught by
/// the program for debugging
/// [code] is an extra field for now for future uses
class CacheFailure extends Failure with EquatableMixin {
  const CacheFailure({
    required super.message,
    super.exception,
    super.code,
  });

  @override
  List<Object?> get props => <Object?>[message, exception, code];
}

class ParseFailure extends Failure with EquatableMixin {
  const ParseFailure({
    required super.message,
    super.exception,
    super.code,
  });

  @override
  List<Object?> get props => <Object?>[message, exception, code];
}
