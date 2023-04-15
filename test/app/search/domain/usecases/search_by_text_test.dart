import 'package:clean_dart/app/search/domain/entities/result_search.dart';
import 'package:clean_dart/app/search/domain/erros/errors.dart';
import 'package:clean_dart/app/search/domain/repositories/search_repository.dart';
import 'package:clean_dart/app/search/domain/usecases/search_by_text.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

//parece que esse mock tá zoando alguma coisa hahaha, complexo

class SearchRepositoryMock extends Mock implements SearchRepository {}

void main() {
  late SearchRepositoryMock repository;
  late SearchByTextImpl usecase;

  setUp(() {
    repository = SearchRepositoryMock();
    usecase = SearchByTextImpl(repository);
  });
  test('Deve me Retornar uma Lista de Result Search', () async {
    //resolvido
    search() => repository.search("searchByText");
    when(search).thenAnswer(
      (_) async => Right(resultSearchExpected),
    );
    final result = await usecase('searchByText');
    //expect(result.fold((l) => l, (r) => r), isA<Right>());
    expect(result, equals(Right(resultSearchExpected)));
  });
  test('Deve me Retornar uma InvalidTextError', () async {
    //resolvido
    search() => repository.search("searchByText");
    when(search).thenAnswer(
      (_) async => Right(resultSearchExpected),
    );
    final result = await usecase('');
    //expect(result.fold((l) => l, (r) => r), isA<Right>());
    expect(result.isLeft(), true);
    expect(result.fold(id, id), isA<InvalidTextError>());
  });
}

final FailureSearch failure = InvalidTextError();
final List<ResultSearch> resultSearchExpected = [
  ResultSearch(
      content: "gdusyagdyusahg", title: "delectus", img: "DGSYUHAGDSYHA")
];
