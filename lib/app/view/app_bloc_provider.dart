import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mintyn/core/injections/injection.dart';
import 'package:mintyn/features/card/presentation/cubit/card_cubit.dart';
import 'package:mintyn/features/home/presentation/cubit/balance_cubit.dart';
import 'package:mintyn/features/home/presentation/cubit/history_cubit.dart';

class BlocProviders {
  static List<BlocProvider> get providers => [
    // Registering the Cubit for Home feature ------------------------------
    BlocProvider<BalanceCubit>(create: (context) => sl<BalanceCubit>()),
    BlocProvider<HistoryCubit>(create: (context) => sl<HistoryCubit>()),
    // Registering the Cubit for Card feature ------------------------------
    BlocProvider<CardCubit>(create: (context) => sl<CardCubit>()),
  ];
}
