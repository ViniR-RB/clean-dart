import '../models/result_search_model.dart';

abstract class SearchDataSource {
  Future<List<ResultSearchModel>> getSearch(String searchText);
}

class SearchDaStringtaSourceImpl implements SearchDataSource {
  @override
  Future<List<ResultSearchModel>> getSearch(String searchText) {
    // TODO: implement getSearch
    throw UnimplementedError();
  }
}
