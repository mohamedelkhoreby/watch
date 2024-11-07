import 'package:dartz/dartz.dart';

import '../model/models.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';
import '../../data/network/failure.dart';

class HomeUseCase extends BaseUseCase<void, MoviesData> {
  final Repository _repository;

  HomeUseCase(this._repository);

  @override
  Future<Either<Failure, MoviesData>> execute(void input) async {
    return await _repository.getHomeData();
  }
}