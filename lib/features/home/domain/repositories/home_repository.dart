import 'package:dartz/dartz.dart';
import 'package:mintyn/features/home/data/models/balance_model.dart';
import 'package:mintyn/features/home/data/models/transactionhistory_model.dart';

import '../../../../core/error/failure.dart';

abstract class HomeRepository {
  Future<Either<Failure, BalanceModel>> getUserBalance();
  Future<Either<Failure, List<TransactionHistoryModel>>> getHistory({String period = 'weekly'});
}
