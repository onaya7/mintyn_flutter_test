import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:mintyn/features/home/data/models/balance_model.dart';
import 'package:mintyn/features/home/domain/repositories/home_repository.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';

@lazySingleton
class GetBalanceUseCase extends UseCase<BalanceModel, NoParams> {
  GetBalanceUseCase({required this.repository});
  final HomeRepository repository;

  @override
  Future<Either<Failure, BalanceModel>> call(NoParams params) =>
      repository.getUserBalance();
}
