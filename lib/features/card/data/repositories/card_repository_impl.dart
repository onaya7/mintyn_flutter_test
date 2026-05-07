import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:mintyn/features/card/data/datasources/card_remote_datasource.dart';
import 'package:mintyn/features/card/data/model/card_model.dart';

import '../../../../core/error/failure.dart';
import '../../../../utils/either_safe_runner.dart';
import '../../domain/repositories/card_repository.dart';

@LazySingleton(as: CardRepository)
class CardRepositoryImpl implements CardRepository {
  const CardRepositoryImpl({required this.datasource});
  final CardRemoteDatasource datasource;

  @override
  Future<Either<Failure, List<CardModel>>> getCards({String type = 'physical'}) =>
      EitherSafeRunner()<List<CardModel>>(
          safeCallback: () => datasource.getCards(type: type));
}
