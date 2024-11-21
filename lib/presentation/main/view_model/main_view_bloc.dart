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

  Future<void> _fetchHomeData(event, emit) async {
    emit(MainViewLoadingState(
        rendererType: StateRendererType.fullScreenLoadingState));
    print(state);
    final result = await _homeUseCase.execute(PageUseCaseInput(event.page));
    result.fold(
      (failure) {
        emit(MainViewErrorState(
            rendererType: StateRendererType.fullScreenErrorState,
            message: failure.message));
      },
      (data) {
        _mainViewObject = MainViewObject(data.page, data.results);
        emit(MainViewContentState());
      },
    );
  }

  _changePage(ChangePageEvent event, Emitter<MainViewState> emit) async {
    if (event.page > 0) {
      _page = _page.copyWith(page: event.page);
      add(FetchHomeDataEvent(event.page));
      print(event.page);
    }
  }
}
