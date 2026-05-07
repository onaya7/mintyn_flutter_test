import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:mintyn/features/home/data/models/transactionhistory_model.dart';
import 'package:mintyn/features/home/domain/repositories/home_repository.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';

class HistoryParams extends Equatable {
  const HistoryParams({this.period = 'weekly'});
  final String period;

  @override
  List<Object> get props => [period];
}

@lazySingleton
class GetHistoryUseCase extends UseCase<List<TransactionHistoryModel>, HistoryParams> {
  GetHistoryUseCase({required this.repository});
  final HomeRepository repository;

  @override
  Future<Either<Failure, List<TransactionHistoryModel>>> call(HistoryParams params) =>
      repository.getHistory(period: params.period);
}
