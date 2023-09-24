part of 'search_bloc.dart';

class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchDataState extends SearchState {
  final List<ProductModel> searchResult;
  final String searchQuery;

  const SearchDataState({
    required this.searchResult,
    required this.searchQuery,
  });

  @override
  List<Object> get props => [searchResult, searchQuery];
}
