import 'package:dartz/dartz.dart';
import 'package:mintyn/features/home/data/models/news_model.dart';

import '../../../../core/error/failure.dart';

// ignore: one_member_abstracts
abstract class HomeRepository {
  Future<Either<Failure, List<NewsModel>>> getNews();
}
