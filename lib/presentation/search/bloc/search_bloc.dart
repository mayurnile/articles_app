import 'package:articles_app/network/models/models.dart';
import 'package:articles_app/network/repositories/articles_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc({required ArticlesRepository articlesRepository})
    : _articlesRepository = articlesRepository,
      super(SearchInitial()) {
    on<SearchArticlesEvent>(_searchArticles);
    on<ClearSearchEvent>(_clearSearch);
  }

  final ArticlesRepository _articlesRepository;

  Future<void> _searchArticles(
    SearchArticlesEvent event,
    Emitter<SearchState> emit,
  ) async {
    emit(SearchLoading());
    final failureOrSuccess = await _articlesRepository.searchArticles(
      event.query,
    );

    failureOrSuccess.fold(
      (failure) {
        emit(SearchError(failure.message));
      },
      (success) {
        emit(SearchLoaded(success));
      },
    );
  }

  Future<void> _clearSearch(
    ClearSearchEvent event,
    Emitter<SearchState> emit,
  ) async {
    emit(SearchInitial());
  }
}
