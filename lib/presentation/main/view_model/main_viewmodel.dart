import 'dart:ffi';

import 'package:flutter/material.dart';

import '../../../domain/model/models.dart';
import '../../../domain/usecase/home_usecase.dart';
import '../../common/state_renderer/state_renderer.dart';
import '../../common/state_renderer/state_renderer_impl.dart';

class MainViewModel extends ChangeNotifier {
  final HomeUseCase _homeUseCase;
  MainViewObject? _mainViewObject;
  FlowState _state = LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState);

  MainViewModel(this._homeUseCase);

  FlowState get state => _state;
  MainViewObject? get mainViewObject => _mainViewObject;

  void start() {
    _fetchHomeData();
  }

  Future<void> _fetchHomeData() async {
_state = LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState);
    notifyListeners(); 

    final result = await _homeUseCase.execute(Void);
    result.fold(
      (failure) {
        _state = ErrorState(StateRendererType.fullScreenErrorState, failure.message);
      },
      (data) {
        _state = ContentState();
        _mainViewObject = MainViewObject(data.results);
      },
    );
    notifyListeners();
  }
}
class MainViewObject {
  final List<Results> movies;
  MainViewObject(this.movies);
}