import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:mintyn/core/error/failure.dart';
import 'package:mintyn/features/home/data/models/balance_model.dart';
import 'package:mintyn/features/home/domain/usecases/getbalance_usecase.dart';

import '../../../../core/usecase/usecase.dart';

part 'balance_cubit.freezed.dart';
part 'balance_state.dart';

@injectable
class BalanceCubit extends Cubit<BalanceState> {
  BalanceCubit({required this.getBalanceUseCase}) : super(const BalanceState.initial());
  final GetBalanceUseCase getBalanceUseCase;

  Future<void> loadBalance() async {
    emit(const BalanceState.loading());
    final result = await getBalanceUseCase(NoParams());
    result.fold(
      (failure) => emit(BalanceState.error(message: ConvertFailureToString()(failure))),
      (balance) => emit(BalanceState.loaded(balance: balance)),
    );
  }
}
