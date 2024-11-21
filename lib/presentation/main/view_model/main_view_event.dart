import 'package:equatable/equatable.dart';

abstract class MainViewEvent extends Equatable {
  const MainViewEvent();
  @override
  List<Object?> get props => [];
}

class FetchHomeDataEvent extends MainViewEvent {
  final int page;

  const FetchHomeDataEvent(this.page);

  @override
  List<Object?> get props => [page];
}
class ChangePageEvent extends MainViewEvent {
  final int page;

  const ChangePageEvent(this.page);

  @override
  List<Object?> get props => [page];
}
