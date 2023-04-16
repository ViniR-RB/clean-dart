// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:clean_dart/app/search/domain/entities/result_search.dart';
import 'package:clean_dart/app/search/domain/erros/errors.dart';
import 'package:dartz/dartz.dart';

import '../../domain/repositories/search_repository.dart';
import '../datasource/search_datasource.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchDataSource dataSource;
  SearchRepositoryImpl({
    required this.dataSource,
  });
  @override
  Future<Either<FailureSearch, List<ResultSearch>>> search(
      String searchText) async {
    try {
      final result = await dataSource.getSearch(searchText);
      return Right(result);
    } on DataSourceError catch (e) {
      return Left(DataSourceError(e.message));
    } catch (e) {
      return Left(DataSourceError(''));
    }
  }
}
