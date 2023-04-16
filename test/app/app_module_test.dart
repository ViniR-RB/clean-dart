import 'dart:convert';

import 'package:clean_dart/app/app_module.dart';
import 'package:clean_dart/app/search/domain/entities/result_search.dart';
import 'package:clean_dart/app/search/domain/usecases/search_by_text.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart' as modular;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:modular_test/modular_test.dart' as modular_test;

import 'search/utils/github_response.dart';

class DioMock extends Mock implements Dio {}

void main() {
  late Dio dio;
  setUp(() {
    dio = DioMock();
    modular_test.initModule(AppModule(), replaceBinds: [
      modular.Bind.instance<Dio>(dio),
    ]);
  });
  test("Deve Recuperar o UseCase sem Error", () async {
    final usecase = modular.Modular.get<SearchByText>();
    expect(usecase, isA<SearchByTextImpl>());
  });
  test("Deve trazer uma lista de ResultSearch", () async {
    final response = Response(
        data: jsonDecode(githubresult), requestOptions: RequestOptions());

    when(() => dio.get(any())).thenAnswer((_) async => response);
    final usecase = modular.Modular.get<SearchByText>();
    final result = await usecase.call("Jacob");
    expect(result.fold(id, id), isA<List<ResultSearch>>());
  });
}
