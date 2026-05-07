part of 'history_cubit.dart';

@freezed
class HistoryState with _$HistoryState {
  const factory HistoryState.initial() = _HistoryInitial;
  const factory HistoryState.loading() = _HistoryLoading;
  const factory HistoryState.loaded({required List<TransactionHistoryModel> transactions}) = _HistoryLoaded;
  const factory HistoryState.error({required String message}) = _HistoryError;
}
