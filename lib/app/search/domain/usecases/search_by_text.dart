import 'package:clean_dart/app/search/domain/entities/result_search.dart';
import 'package:dartz/dartz.dart';

import '../erros/errors.dart';
import '../repositories/search_repository.dart';

abstract class SearchByText {
  Future<Either<FailureSearch, List<ResultSearch>>> call(String searchText);
}

class SearchByTextImpl implements SearchByText {
  SearchRepository repository;

  SearchByTextImpl(this.repository);

  @override
  Future<Either<FailureSearch, List<ResultSearch>>> call(
      String searchText) async {
    if (searchText.isEmpty) {
      return Left(InvalidTextError());
    }
    final response = await repository.search(searchText);
    return response;
  }
}
