import 'package:flutter/material.dart';
import 'package:watch/presentation/common/frezzed/freezed_data_classes.dart';

import '../../../domain/model/models.dart';
import '../../../domain/usecase/home_usecase.dart';
import '../../common/state_renderer/state_renderer.dart';
import '../../common/state_renderer/state_renderer_impl.dart';

class MainViewModel extends ChangeNotifier {
  final HomeUseCase _homeUseCase;
  MainViewObject? _mainViewObject;
  FlowState _state =
      LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState);

  MainViewModel(this._homeUseCase);

  FlowState get state => _state;
  MainViewObject? get mainViewObject => _mainViewObject;
  var _page = PageObject(1);
  void start() {
    _fetchHomeData();
  }

  setPageNum(int page) {
    if (page > 0) {
      _page = _page.copyWith(page: page);
      start(); // Fetch new data for updated page
    }
  }

  Future<void> _fetchHomeData() async {
    _state = LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState);
    notifyListeners();

    final result = await _homeUseCase.execute(PageUseCaseInput(_page.page));

    result.fold(
      (failure) {
        _state =
            ErrorState(StateRendererType.fullScreenErrorState, failure.message);
      },
      (data) {
        _state = ContentState();
        _mainViewObject = MainViewObject(data.page, data.results);
      },
    );

    notifyListeners();
  }
}

class MainViewObject {
  final int page;
  final List<Results> movies;
  MainViewObject(this.page, this.movies);
}
