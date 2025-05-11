part of 'favourites_bloc.dart';

sealed class FavouritesState extends Equatable {
  const FavouritesState();
}

final class FavouritesInitial extends FavouritesState {
  @override
  List<Object> get props => [];
}

final class FavouritesLoading extends FavouritesState {
  @override
  List<Object> get props => [];
}

final class FavouritesLoaded extends FavouritesState {
  const FavouritesLoaded(this.favourites);

  final List<ArticleModel> favourites;

  @override
  List<Object> get props => [favourites];
}

final class FavouritesError extends FavouritesState {
  const FavouritesError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
