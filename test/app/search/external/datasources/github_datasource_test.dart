import 'dart:convert';

import 'package:clean_dart/app/search/domain/erros/errors.dart';
import 'package:clean_dart/app/search/external/datasources/github_datasource.dart';
import 'package:clean_dart/app/search/infra/datasource/search_datasource.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../utils/github_response.dart';

class DioMock extends Mock implements Dio {}

void main() {
  final dio = DioMock();
  final SearchDataSource datasource = GithubDataSource(dio);
  setUp(() {});
  test("deve retornar uma lista de ResultSearchModel", () async {
    final response = Response(
        requestOptions: RequestOptions(path: ''),
        data: jsonDecode(githubresult),
        statusCode: 200);
    when(() => dio.get(any())).thenAnswer((_) async => response);
    final result = datasource.getSearch("searchText");
    expect(result, completes);
  });

  test("deve retornar um erro se o statusCode não for 200", () async {
    final response = Response(
        requestOptions: RequestOptions(path: ''), data: null, statusCode: 401);
    when(() => dio.get(any())).thenAnswer((_) async => response);
    final result = datasource.getSearch("searchText");
    expect(result, throwsA(isA<DataSourceError>()));
  });

  test("deve retornar um Exception se for error no Dio", () async {
    final response = Response(
        requestOptions: RequestOptions(path: ''), data: null, statusCode: 401);
    when(() => dio.get(any())).thenThrow(Exception());
    final result = datasource.getSearch("searchText");
    expect(result, throwsA(isA<Exception>()));
  });
}
