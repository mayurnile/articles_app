import 'dart:async';

import 'package:articles_app/network/models/models.dart';
import 'package:articles_app/network/repositories/favourites_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'favourites_event.dart';
part 'favourites_state.dart';

class FavouritesBloc extends Bloc<FavouritesEvent, FavouritesState> {
  FavouritesBloc({required FavouritesRepository favouritesRepository})
    : _favouritesRepository = favouritesRepository,
      super(FavouritesInitial()) {
    on<FetchFavouritesEvent>(_fetchFavourites);
    on<AddToFavouritesEvent>(_addToFavourites);
    on<RemoveFromFavouritesEvent>(_removeFromFavourites);
  }

  final FavouritesRepository _favouritesRepository;

  FutureOr<void> _fetchFavourites(
    FetchFavouritesEvent event,
    Emitter<FavouritesState> emit,
  ) async {
    emit(FavouritesLoading());
    final failureOrFavourites = await _favouritesRepository.getFavourites();
    failureOrFavourites.fold(
      (failure) => emit(FavouritesError(failure.message)),
      (favourites) => emit(FavouritesLoaded(favourites)),
    );
  }

  FutureOr<void> _addToFavourites(
    AddToFavouritesEvent event,
    Emitter<FavouritesState> emit,
  ) async {
    final currentFavourites =
        state is FavouritesLoaded
            ? (state as FavouritesLoaded).favourites
            : <ArticleModel>[];

    final failureOrFavourites = await _favouritesRepository.addToFavourites(
      article: event.article,
    );
    failureOrFavourites.fold(
      (failure) => emit(FavouritesError(failure.message)),
      (success) {
        if (success) {
          currentFavourites.add(event.article);
          emit(FavouritesLoaded(currentFavourites));
        }
      },
    );
  }

  FutureOr<void> _removeFromFavourites(
    RemoveFromFavouritesEvent event,
    Emitter<FavouritesState> emit,
  ) async {
    final currentFavourites =
        state is FavouritesLoaded
            ? (state as FavouritesLoaded).favourites
            : <ArticleModel>[];

    final failureOrFavourites = await _favouritesRepository
        .removeFromFavourites(articleId: event.article.id);
    failureOrFavourites.fold(
      (failure) => emit(FavouritesError(failure.message)),
      (success) {
        if (success) {
          currentFavourites.remove(event.article);
          emit(FavouritesLoaded(currentFavourites));
        }
      },
    );
  }
}
