abstract class SearchEvent {}

class SearchEventStartEvent extends SearchEvent {}

class SearchEventLoadingEvent extends SearchEvent {}

class SearchSucessEvent implements SearchEvent {}

class SearchErrorEvent extends SearchEvent {}
