// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:dio_http_cache_fix/dio_http_cache.dart' as _i633;
import 'package:get_it/get_it.dart' as _i174;
import 'package:hive_flutter/hive_flutter.dart' as _i986;
import 'package:injectable/injectable.dart' as _i526;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i973;
import 'package:mintyn/core/injections/register_module.dart' as _i577;
import 'package:mintyn/core/local_data/local_data_storage.dart' as _i42;
import 'package:mintyn/core/network_info/network_info.dart' as _i516;
import 'package:mintyn/features/home/data/datasources/home_remote_datasource.dart'
    as _i682;
import 'package:mintyn/features/home/data/repositories/home_repository_impl.dart'
    as _i203;
import 'package:mintyn/features/home/domain/repositories/home_repository.dart'
    as _i70;
import 'package:mintyn/features/home/domain/usecases/getbalance_usecase.dart'
    as _i500;
import 'package:mintyn/features/home/domain/usecases/gethistory_usecase.dart'
    as _i660;
import 'package:mintyn/features/home/domain/usecases/getnews_usecase.dart'
    as _i393;
import 'package:mintyn/features/home/presentation/cubit/balance_cubit.dart'
    as _i929;
import 'package:mintyn/features/home/presentation/cubit/history_cubit.dart'
    as _i635;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt init(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final registerModule = _$RegisterModule();
  gh.factory<_i986.Box<dynamic>>(() => registerModule.box);
  gh.factory<_i973.InternetConnectionChecker>(
      () => registerModule.internetConnectionChecker);
  gh.factory<_i633.DioCacheManager>(() => registerModule.dioCacheManager);
  gh.factory<_i361.Dio>(() => registerModule.dio);
  gh.lazySingleton<_i516.NetworkInfo>(
      () => _i516.NetworkInfoImpl(gh<_i973.InternetConnectionChecker>()));
  gh.lazySingleton<_i42.LocalDataStorage>(
      () => _i42.LocalDataStorageImpl(gh<_i986.Box<dynamic>>()));
  gh.lazySingleton<_i682.HomeRemoteDatasource>(
      () => _i682.HomeRemoteDatasourceImpl(
            networkInfo: gh<_i516.NetworkInfo>(),
            localDataStorage: gh<_i42.LocalDataStorage>(),
            dio: gh<_i361.Dio>(),
          ));
  gh.lazySingleton<_i70.HomeRepository>(() => _i203.HomeRepositoryImpl(
        datasource: gh<_i682.HomeRemoteDatasource>(),
        localDataStorage: gh<_i42.LocalDataStorage>(),
      ));
  gh.lazySingleton<_i660.GetHistoryUseCase>(
      () => _i660.GetHistoryUseCase(repository: gh<_i70.HomeRepository>()));
  gh.lazySingleton<_i500.GetBalanceUseCase>(
      () => _i500.GetBalanceUseCase(repository: gh<_i70.HomeRepository>()));
  gh.lazySingleton<_i393.GetBalanceUseCase>(
      () => _i393.GetBalanceUseCase(repository: gh<_i70.HomeRepository>()));
  gh.factory<_i635.HistoryCubit>(() =>
      _i635.HistoryCubit(getHistoryUseCase: gh<_i660.GetHistoryUseCase>()));
  gh.factory<_i929.BalanceCubit>(() =>
      _i929.BalanceCubit(getBalanceUseCase: gh<_i500.GetBalanceUseCase>()));
  return getIt;
}

class _$RegisterModule extends _i577.RegisterModule {}
