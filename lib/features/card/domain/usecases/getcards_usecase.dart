import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:mintyn/features/card/data/model/card_model.dart';
import 'package:mintyn/features/card/domain/repositories/card_repository.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';

class CardTypeParams extends Equatable {
  const CardTypeParams({this.type = 'physical'});
  final String type;

  @override
  List<Object> get props => [type];
}

@lazySingleton
class GetCardsUseCase extends UseCase<List<CardModel>, CardTypeParams> {
  GetCardsUseCase({required this.repository});
  final CardRepository repository;

  @override
  Future<Either<Failure, List<CardModel>>> call(CardTypeParams params) =>
      repository.getCards(type: params.type);
}
