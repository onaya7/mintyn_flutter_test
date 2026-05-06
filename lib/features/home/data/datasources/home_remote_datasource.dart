import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:injectable/injectable.dart';
import 'package:mintyn/core/constants/app_url.dart';
import 'package:mintyn/features/home/data/models/news_model.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../../../core/local_data/local_data_storage.dart';
import '../../../../core/network_info/api_client.dart';
import '../../../../core/network_info/network_info.dart';
import '../../../../utils/internet_safe_runner.dart';

// ignore: one_member_abstracts
abstract class HomeRemoteDatasource {
  Future<List<NewsModel>> getNews();
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
  Future<List<NewsModel>> getNews() async {
    return internetSafeRunner<List<NewsModel>>(
      safeCallback: () async {
        final response = await client.getRequest(path: AppUrl.getHomeData(), query: {});
        final result = response.data; // Extract data from HttpResponse
        if (result is List) {
          return result.map((e) => NewsModel.fromJson(e as Map<String, dynamic>)).toList();
        } else {
          throw Exception('Unexpected response format');
        }
      },
    );
  }
}
