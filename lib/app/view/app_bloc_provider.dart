import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mintyn/core/injections/injection.dart';
import 'package:mintyn/features/home/presentation/cubit/home_cubit.dart';

class BlocProviders {
  static List<BlocProvider> get providers => [
    // Registering the Cubit for Home feature ------------------------------
    BlocProvider<HomeCubit>(create: (context) => sl<HomeCubit>()),
  ];
}
