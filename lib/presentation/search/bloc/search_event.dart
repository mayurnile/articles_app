part of 'search_bloc.dart';

sealed class SearchEvent extends Equatable {
  const SearchEvent();
}

final class SearchArticlesEvent extends SearchEvent {
  const SearchArticlesEvent({required this.query});

  final String query;

  @override
  List<Object?> get props => [query];
}

final class ClearSearchEvent extends SearchEvent {
  const ClearSearchEvent();

  @override
  List<Object?> get props => [];
}
