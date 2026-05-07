import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:mintyn/core/constants/app_url.dart';
import 'package:mintyn/features/home/data/models/balance_model.dart';
import 'package:mintyn/features/home/data/models/transactionhistory_model.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../../../core/local_data/local_data_storage.dart';
import '../../../../core/network_info/api_client.dart';
import '../../../../core/network_info/network_info.dart';
import '../../../../utils/internet_safe_runner.dart';

abstract class HomeRemoteDatasource {
  Future<BalanceModel> getUserBalance();
  Future<List<TransactionHistoryModel>> getHistory({String period = 'weekly'});
}

final PrettyDioLogger _prettyDioLogger = PrettyDioLogger(requestHeader: true, requestBody: true);

final RetryInterceptor _retryInterceptor = RetryInterceptor(
  dio: Dio(),
  logPrint: print, // retry count (optional)
  retryDelays: const [
    Duration(seconds: 1), // wait 1 sec before first retry
    Duration(seconds: 2), // wait 2 sec before second retry
    Duration(seconds: 3), // wait 3 sec before third retry
  ],
);

@LazySingleton(as: HomeRemoteDatasource)
class HomeRemoteDatasourceImpl implements HomeRemoteDatasource {
  HomeRemoteDatasourceImpl({required this.networkInfo, required this.localDataStorage, required this.dio}) : super() {
    dio.interceptors.add(_prettyDioLogger);
    dio.interceptors.add(_retryInterceptor);
    client = ApiClient(dio, baseUrl: AppUrl.baseUrl);
    internetSafeRunner = InternetSafeRunner(networkInfo);
  }
  final NetworkInfo networkInfo;
  final LocalDataStorage localDataStorage;
  final Dio dio;
  late final ApiClient client;
  late final InternetSafeRunner internetSafeRunner;

  @override
  Future<BalanceModel> getUserBalance() async {
    await Future<void>.delayed(const Duration(milliseconds: 800));
    final jsonString = await rootBundle.loadString('assets/data/balance.json');
    final json = jsonDecode(jsonString) as Map<String, dynamic>;
    return BalanceModel.fromJson(json);
  }

  @override
  Future<List<TransactionHistoryModel>> getHistory({String period = 'weekly'}) async {
    await Future<void>.delayed(const Duration(milliseconds: 600));
    final jsonString = await rootBundle.loadString('assets/data/transaction.json');
    final json = jsonDecode(jsonString) as Map<String, dynamic>;
    final data = json['data'] as Map<String, dynamic>;
    final list = data[period.toLowerCase()] as List<dynamic>? ?? [];
    return list.map((e) => TransactionHistoryModel.fromJson(e as Map<String, dynamic>)).toList();
  }
}
