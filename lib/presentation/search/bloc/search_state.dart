part of 'search_bloc.dart';

sealed class SearchState extends Equatable {
  const SearchState();
}

final class SearchInitial extends SearchState {
  @override
  List<Object> get props => [];
}

final class SearchLoading extends SearchState {
  @override
  List<Object> get props => [];
}

final class SearchLoaded extends SearchState {
  const SearchLoaded(this.articles);

  final List<ArticleModel> articles;

  @override
  List<Object> get props => [articles];
}

final class SearchError extends SearchState {
  const SearchError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
