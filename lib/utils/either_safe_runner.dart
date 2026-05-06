import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:mintyn/core/error/error.dart';
import 'package:mintyn/core/error/failure.dart';
import 'package:mintyn/utils/logger.dart';

class EitherSafeRunner {
  Future<Either<Failure, T>> call<T>({required Future<T> Function() safeCallback}) async {
    try {
      return Right(await safeCallback());
    } catch (e, stackTrace) {
      logger.e('EitherSafeRunner', error: e, stackTrace: stackTrace);

      if (e is DioException) {
        final data = e.response!.data as Map<String, dynamic>;
        if (!kDebugMode) {
          if (e.response != null && e.response!.statusCode! >= 500) {
            return const Left(Failure.serverError('Service Unavailable'));
          }
        }
        if (e.response!.statusCode == 401 && data['message'] == 'Token has expired') {
          return const Left(Failure.serverError('Session Expired, Please Login'));
        }
        if (e.response!.data != null && e.response!.data != '') {
          return Left(Failure.serverError(data['message'] as String));
        } else {
          return const Left(Failure.serverError('Server error, please try again'));
        }
      }
      if (e is MintynException) {
        return Left(
          e.map(
            server: (exception) => Failure.serverError(exception.message),
            noInternet: (exception) => const Failure.noInternet(),
            unknown: (exception) => const Failure.unknown(),
            app: (exception) => Failure.app(exception.message),
          ),
        );
      }
      return const Left(Failure.unknown());
    }
  }
}
