import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:mintyn/features/home/data/datasources/home_remote_datasource.dart';
import 'package:mintyn/features/home/data/models/balance_model.dart';
import 'package:mintyn/features/home/data/models/transactionhistory_model.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/local_data/local_data_storage.dart';
import '../../../../utils/either_safe_runner.dart';
import '../../domain/repositories/home_repository.dart';

@LazySingleton(as: HomeRepository)
class HomeRepositoryImpl implements HomeRepository {
  const HomeRepositoryImpl({required this.datasource, required this.localDataStorage});
  final HomeRemoteDatasource datasource;
  final LocalDataStorage localDataStorage;

  @override
  Future<Either<Failure, BalanceModel>> getUserBalance() =>
      EitherSafeRunner()<BalanceModel>(safeCallback: datasource.getUserBalance);

  @override
  Future<Either<Failure, List<TransactionHistoryModel>>> getHistory({String period = 'weekly'}) =>
      EitherSafeRunner()<List<TransactionHistoryModel>>(safeCallback: () => datasource.getHistory(period: period));
}
