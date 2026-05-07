import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:mintyn/core/error/failure.dart';
import 'package:mintyn/features/home/data/models/transactionhistory_model.dart';
import 'package:mintyn/features/home/domain/usecases/gethistory_usecase.dart';

part 'history_cubit.freezed.dart';
part 'history_state.dart';

@injectable
class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit({required this.getHistoryUseCase}) : super(const HistoryState.initial());
  final GetHistoryUseCase getHistoryUseCase;

  Future<void> loadHistory({String period = 'weekly'}) async {
    emit(const HistoryState.loading());
    final result = await getHistoryUseCase(HistoryParams(period: period));
    result.fold(
      (failure) => emit(HistoryState.error(message: ConvertFailureToString()(failure))),
      (transactions) => emit(HistoryState.loaded(transactions: transactions)),
    );
  }
}
