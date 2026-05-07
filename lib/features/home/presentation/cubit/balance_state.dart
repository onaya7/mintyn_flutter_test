part of 'balance_cubit.dart';

@freezed
class BalanceState with _$BalanceState {
  const factory BalanceState.initial() = _BalanceInitial;
  const factory BalanceState.loading() = _BalanceLoading;
  const factory BalanceState.loaded({required BalanceModel balance}) = _BalanceLoaded;
  const factory BalanceState.error({required String message}) = _BalanceError;
}
