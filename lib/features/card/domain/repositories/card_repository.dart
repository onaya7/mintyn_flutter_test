import 'package:dartz/dartz.dart';
import 'package:mintyn/features/card/data/model/card_model.dart';

import '../../../../core/error/failure.dart';

abstract class CardRepository {
  Future<Either<Failure, List<CardModel>>> getCards({String type = 'physical'});
}
