import 'package:dartz/dartz.dart';
import 'package:watch/data/network/request.dart';

import '../model/models.dart';
import '../../data/network/failure.dart';

abstract class Repository {
  Future<Either<Failure, MoviesData>> getHomeData(PageRequest pageRequest);
}
