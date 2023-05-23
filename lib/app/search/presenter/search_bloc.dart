import 'package:clean_dart/app/search/presenter/states/search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../domain/usecases/search_by_text.dart';

class SearchBloc extends Bloc<String, SearchState> {
  final SearchByText useCase;
  SearchBloc(this.useCase) : super(SearchStartState()) {
    on<String>(
      (event, emit) async {
        emit(SearchStartState());
        emit(SearchLoadingState());
        emit(await _emit(event));
      },
    );
  }

  Stream<SearchState> map(String searchText) async* {
    yield SearchLoadingState();
    final result = await useCase(searchText);
    yield result.fold((l) => SearchErrorState(l), (r) => SearchSucessState(r));
  }

  Future<SearchState> _emit(String searchText) async {
    final result = await useCase(searchText);
    return result.fold((l) => SearchErrorState(l), (r) => SearchSucessState(r));
  }
}
