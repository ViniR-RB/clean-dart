import 'package:clean_dart/app/search/domain/entities/result_search.dart';
import 'package:clean_dart/app/search/domain/erros/errors.dart';
import 'package:clean_dart/app/search/domain/usecases/search_by_text.dart';
import 'package:clean_dart/app/search/presenter/search_bloc.dart';
import 'package:clean_dart/app/search/presenter/states/search_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class SearchByTextMock extends Mock implements SearchByText {}

void main() {
  final usecase = SearchByTextMock();
  final SearchBloc bloc = SearchBloc(usecase);
  test('deve me retornar os estados na ordem Correta', () async* {
    when(() => usecase(any()))
        .thenAnswer((_) async => const Right(<ResultSearch>[]));
    expect(
        bloc,
        emitsInOrder([
          isA<SearchLoading>(),
          isA<SearchSucess>(),
        ]));
    bloc.add("vinicius");
  });

  test('deve um Erro', () async* {
    when(() => usecase(any()))
        .thenAnswer((_) async => Left(InvalidTextError()));
    expect(
        bloc,
        emitsInOrder([
          isA<SearchLoading>(),
          isA<SearchError>(),
        ]));
    bloc.add("vinicius");
  });
}
