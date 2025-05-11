import 'dart:async';

import 'package:articles_app/network/models/models.dart';
import 'package:articles_app/network/repositories/articles_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'articles_event.dart';
part 'articles_state.dart';

class ArticlesBloc extends Bloc<ArticlesEvent, ArticlesState> {
  ArticlesBloc({required ArticlesRepository articlesRepository})
    : _articlesRepository = articlesRepository,
      super(ArticlesInitial()) {
    on<FetchArticlesEvent>(_onFetchArticles);
  }

  final ArticlesRepository _articlesRepository;

  FutureOr<void> _onFetchArticles(
    FetchArticlesEvent event,
    Emitter<ArticlesState> emit,
  ) async {
    emit(ArticlesLoading());

    final failureOrSuccess = await _articlesRepository.getArticles();

    failureOrSuccess.fold(
      (failure) {
        emit(ArticlesError(failure.message));
      },
      (articles) {
        emit(ArticlesLoaded(articles));
      },
    );
  }
}
