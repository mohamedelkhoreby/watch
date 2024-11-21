import '../../common/state_renderer/state_renderer.dart';
import '../../common/state_renderer/state_renderer_impl.dart';

abstract class MainViewState extends FlowState {}

class MainViewLoadingState extends LoadingState implements MainViewState {
  MainViewLoadingState({required StateRendererType rendererType, super.message = "Loading"})
      : super(stateRendererType: rendererType);
}

class MainViewErrorState extends ErrorState implements MainViewState {
  MainViewErrorState({required StateRendererType rendererType, required String message})
      : super(rendererType, message);
}

class MainViewContentState extends ContentState implements MainViewState {
  MainViewContentState() : super();
}

class MainViewEmptyState extends EmptyState implements MainViewState {
  MainViewEmptyState(super.message);
}

class MainViewSuccessState extends SuccessState implements MainViewState {
  MainViewSuccessState(super.message);
}
