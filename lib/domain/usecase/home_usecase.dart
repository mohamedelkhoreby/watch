import 'package:dartz/dartz.dart';

import '../../data/network/request.dart';
import '../model/models.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';
import '../../data/network/failure.dart';

class HomeUseCase extends BaseUseCase<PageUseCaseInput, MoviesData> {
  final Repository _repository;

  HomeUseCase(this._repository);

  @override
  Future<Either<Failure, MoviesData>> execute(PageUseCaseInput input) async {
    return await _repository.getHomeData(PageRequest(input.pages));
  }
}

class PageUseCaseInput {
  int pages;

  PageUseCaseInput(this.pages);
}
