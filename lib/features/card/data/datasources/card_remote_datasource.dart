import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:mintyn/core/constants/app_url.dart';
import 'package:mintyn/features/card/data/model/card_model.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../../../core/local_data/local_data_storage.dart';
import '../../../../core/network_info/api_client.dart';
import '../../../../core/network_info/network_info.dart';
import '../../../../utils/internet_safe_runner.dart';

// ignore: one_member_abstracts
abstract class CardRemoteDatasource {
  Future<List<CardModel>> getCards({String type = 'physical'});
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

@LazySingleton(as: CardRemoteDatasource)
class CardRemoteDatasourceImpl implements CardRemoteDatasource {
  CardRemoteDatasourceImpl({required this.networkInfo, required this.localDataStorage, required this.dio}) : super() {
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
  Future<List<CardModel>> getCards({String type = 'physical'}) async {
    await Future<void>.delayed(const Duration(milliseconds: 700));
    final jsonString = await rootBundle.loadString('assets/data/card.json');
    final json = jsonDecode(jsonString) as Map<String, dynamic>;
    final data = json['data'] as Map<String, dynamic>;
    final list = data[type.toLowerCase()] as List<dynamic>? ?? [];
    return list.map((e) => CardModel.fromJson(e as Map<String, dynamic>)).toList();
  }
}
