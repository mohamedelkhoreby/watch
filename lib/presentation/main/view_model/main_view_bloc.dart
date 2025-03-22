import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/model/models.dart';
import '../../../domain/usecase/home_usecase.dart';
import '../../common/frezzed/freezed_data_classes.dart';
import '../../common/state_renderer/state_renderer.dart';
import 'main_view_event.dart';
import 'main_view_state.dart';

class MainViewBloc extends Bloc<MainViewEvent, MainViewState> {
  MainViewBloc(this._homeUseCase)
      : super(MainViewLoadingState(
            rendererType: StateRendererType.fullScreenLoadingState)) {
    on<FetchHomeDataEvent>(_fetchHomeData);
    on<ChangePageEvent>(_changePage);
  }
  final HomeUseCase _homeUseCase;
  MainViewObject? _mainViewObject;
  var _page = PageObject(1);

  MainViewObject? get mainViewObject => _mainViewObject;

  Future<void> _fetchHomeData(
      FetchHomeDataEvent event, Emitter<MainViewState> emit) async {
    emit(MainViewLoadingState(
        rendererType: StateRendererType.fullScreenLoadingState));
    final result = await _homeUseCase.execute(PageUseCaseInput(event.page));
    result.fold(
      (failure) {
        emit(MainViewErrorState(
            rendererType: StateRendererType.fullScreenErrorState,
            message: failure.message));
      },
      (data) {
        _mainViewObject = MainViewObject(data.page, data.results);
        _page = _page.copyWith(page: data.page);
        emit(MainViewContentState());
      },
    );
  }

  void _changePage(ChangePageEvent event, Emitter<MainViewState> emit) {
    if (event.page > 0 && event.page != _page.page) {
      if (_mainViewObject != null) {
        _mainViewObject = _mainViewObject!.copyWith(page: event.page);
      }
      emit(MainViewLoadingState(
          rendererType: StateRendererType.fullScreenLoadingState));

      add(FetchHomeDataEvent(event.page));
    } else {}
  }
}
