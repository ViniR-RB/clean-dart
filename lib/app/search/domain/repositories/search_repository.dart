import 'package:dartz/dartz.dart';

import '../entities/result_search.dart';
import '../erros/errors.dart';

abstract class SearchRepository {
  Future<Either<FailureSearch, List<ResultSearch>>> search(String searchText);
}
