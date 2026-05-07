import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:mintyn/core/error/failure.dart';
import 'package:mintyn/features/card/data/datasources/card_remote_datasource.dart';
import 'package:mintyn/features/card/data/model/card_model.dart';
import 'package:mintyn/features/card/domain/usecases/getcards_usecase.dart';

part 'card_cubit.freezed.dart';
part 'card_state.dart';

@injectable
class CardCubit extends Cubit<CardState> {
  CardCubit({required this.getCardsUseCase, required this.datasource}) : super(const CardState.initial());

  final GetCardsUseCase getCardsUseCase;
  final CardRemoteDatasource datasource;

  Map<String, int> cardCounts = {};

  Future<void> loadCounts() async {
    cardCounts = await datasource.getCardCounts();
    emit(state); // re-emit current state to trigger BlocBuilder rebuild
  }

  Future<void> loadCards({String type = 'physical'}) async {
    emit(const CardState.loading());
    final result = await getCardsUseCase(CardTypeParams(type: type));
    result.fold(
      (failure) => emit(CardState.error(message: ConvertFailureToString()(failure))),
      (cards) => emit(CardState.loaded(cards: cards)),
    );
  }
}
