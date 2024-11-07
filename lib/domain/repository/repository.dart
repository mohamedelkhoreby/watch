import 'package:dartz/dartz.dart';

import '../model/models.dart';
import '../../data/network/failure.dart';

abstract class Repository {
  Future<Either<Failure, MoviesData>> getHomeData();
}
