import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:mintyn/features/home/data/datasources/home_remote_datasource.dart';
import 'package:mintyn/features/home/data/models/news_model.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/local_data/local_data_storage.dart';
import '../../../../utils/either_safe_runner.dart';
import '../../domain/repositories/home_repository.dart';

@LazySingleton(as: HomeRepository)
class HomeRepositoryImpl implements HomeRepository {
  const HomeRepositoryImpl({required this.datasource, required this.localDataStorage});
  final HomeRemoteDatasource datasource;

  final LocalDataStorage localDataStorage;

  @override
  Future<Either<Failure, List<NewsModel>>> getNews() {
    return EitherSafeRunner()<List<NewsModel>>(
      safeCallback: () async {
        final news = await datasource.getNews();
        return news;
      },
    );
  }
}
