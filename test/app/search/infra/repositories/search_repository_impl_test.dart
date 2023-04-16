import 'package:clean_dart/app/search/domain/erros/errors.dart';
import 'package:clean_dart/app/search/domain/repositories/search_repository.dart';
import 'package:clean_dart/app/search/infra/datasource/search_datasource.dart';
import 'package:clean_dart/app/search/infra/models/result_search_model.dart';
import 'package:clean_dart/app/search/infra/repositories/search_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class SearchDataSourceMock extends Mock implements SearchDataSource {}

void main() {
  late SearchDataSourceMock dataSource = SearchDataSourceMock();
  late SearchRepository repository;
  setUp(() {
    dataSource = SearchDataSourceMock();
    repository = SearchRepositoryImpl(dataSource: dataSource);
  });
  test('deve me retornar uma lista de ResultSearch', () async {
    when(() => dataSource.getSearch("searchText"))
        .thenAnswer((_) async => resultSearchExpected);
    final result = await repository.search("searchText");

    expect(result.isRight(), true);
    expect(result.fold(id, id), isA<List<ResultSearchModel>>());
  });
  test('deve me retornar um DataSourceError se o DataSource Falhar', () async {
    when(() => dataSource.getSearch("searchText")).thenThrow(Exception());

    final result = await repository.search("searchText");

    expect(result.isLeft(), true);
    expect(result.fold(id, id), isA<DataSourceError>());
  });
}

final List<ResultSearchModel> resultSearchExpected = [
  ResultSearchModel(
      content: "gdusyagdyusahg", title: "delectus", img: "DGSYUHAGDSYHA")
];
