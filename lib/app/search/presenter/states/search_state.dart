import '../../domain/entities/result_search.dart';
import '../../domain/erros/errors.dart';

abstract class SearchState {}

class SearchStartState implements SearchState {}

class SearchLoadingState implements SearchState {}

class SearchSucessState implements SearchState {
  final List<ResultSearch> list;
  SearchSucessState(this.list);
}

class SearchErrorState implements SearchState {
  final FailureSearch error;
  SearchErrorState(this.error);
}
