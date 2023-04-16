import 'package:clean_dart/app/search/domain/erros/errors.dart';
import 'package:clean_dart/app/search/infra/datasource/search_datasource.dart';
import 'package:clean_dart/app/search/infra/models/result_search_model.dart';
import 'package:dio/dio.dart';

extension on String {
  normalize() {
    return replaceAll(" ", "+");
  }
}

class GithubDataSource implements SearchDataSource {
  final Dio dio;
  GithubDataSource(this.dio);
  @override
  Future<List<ResultSearchModel>> getSearch(String searchText) async {
    final response = await dio
        .get("https://api.github.com/search/users?q=${searchText.normalize()}");
    if (response.statusCode == 200) {
      final list = (response.data['items'] as List)
          .map((e) => ResultSearchModel.fromMap(e))
          .toList();
      return list;
    } else {
      throw DataSourceError('');
    }
  }
}
