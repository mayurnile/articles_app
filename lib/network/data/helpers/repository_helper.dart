import 'dart:async';

import 'package:articles_app/core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';

abstract class RepositoryHelper<T> {
  Future<Either<Failure, T>> callAPI(
    FutureOr<T> Function() apiCall, {
    bool checkOfflineDB = false,
  });

  Future<Either<Failure, T>> callOfflineDb(FutureOr<T> Function() call);
}

class RepositoryHelperImpl<T> extends RepositoryHelper<dynamic> {
  RepositoryHelperImpl({
    required DataConnectionChecker connectionChecker,
  }) : _connectionChecker = connectionChecker;

  final DataConnectionChecker _connectionChecker;

  @override
  Future<Either<Failure, dynamic>> callAPI(
    FutureOr<dynamic> Function() apiCall, {
    // flag for bypassing network check at repository level
    bool checkOfflineDB = false,
  }) async {
    try {
      // If device is connected to internet we'll make a network call
      // if device is not the throw an error, but if checkOfflineDB is true
      // i.e. we want to bypass because some data needs to be shown on FE
      // in that case we'll fetch data from local db and this condition is
      // further handled in the datasource layer
      if (await _connectionChecker.hasConnection || checkOfflineDB) {
        return Right<Failure, dynamic>(await apiCall());
      } else {
        throw const DeviceException(message: kDeivceExceptionMessage);
      }
    } on DioException catch (e) {
      final exception = e.error;
      if (exception is ServerException) {
        return Left<Failure, dynamic>(
          ServerFailure(
            message: exception.message,
            exception: exception.exception,
            code: exception.code,
          ),
        );
      }

      if (exception is AuthException) {
        return Left<Failure, dynamic>(
          AuthFailure(
            message: exception.message,
            exception: exception.exception,
            code: exception.code,
          ),
        );
      }

      if (exception is DeviceException) {
        return Left<Failure, dynamic>(
          DeviceFailure(
            message: kDeivceExceptionMessage,
            exception: e.toString(),
          ),
        );
      }
      return Left<Failure, dynamic>(
        ServerFailure(message: e.message ?? kSomethingUnexpected),
      );
    } on DeviceException catch (e) {
      return Left<Failure, dynamic>(
        DeviceFailure(
          message: e.message,
          exception: e.toString(),
          code: e.code,
        ),
      );
    } on CacheException catch (e) {
      return Left<Failure, dynamic>(
        CacheFailure(
          message: e.message,
          exception: e.exception,
          code: e.code,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, dynamic>> callOfflineDb(
    FutureOr<dynamic> Function() call,
  ) async {
    try {
      return Right<Failure, dynamic>(await call());
    } on CacheException catch (e) {
      return Left<Failure, dynamic>(
        CacheFailure(
          message: e.message,
          exception: e.exception,
          code: e.code,
        ),
      );
    } on Exception catch (e) {
      return Left<Failure, dynamic>(
        DeviceFailure(
          message: kSomethingUnexpected,
          exception: e.toString(),
          code: 0,
        ),
      );
    }
  }
}
