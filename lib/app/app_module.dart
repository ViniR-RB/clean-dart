import 'package:clean_dart/app/search/domain/usecases/search_by_text.dart';
import 'package:clean_dart/app/search/external/datasources/github_datasource.dart';
import 'package:clean_dart/app/search/infra/repositories/search_repository_impl.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => SearchByTextImpl(i.get())),
        Bind((i) => Dio()),
        Bind((i) => SearchRepositoryImpl(dataSource: i.get())),
        Bind((i) => GithubDataSource(i.get())),
      ];

  @override
  final List<ModularRoute> routes = [];
}
