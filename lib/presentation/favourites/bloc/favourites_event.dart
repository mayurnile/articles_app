part of 'favourites_bloc.dart';

sealed class FavouritesEvent extends Equatable {
  const FavouritesEvent();
}

final class FetchFavouritesEvent extends FavouritesEvent {
  const FetchFavouritesEvent();

  @override
  List<Object?> get props => [];
}

final class AddToFavouritesEvent extends FavouritesEvent {
  const AddToFavouritesEvent(this.article);

  final ArticleModel article;

  @override
  List<Object?> get props => [article];
}

final class RemoveFromFavouritesEvent extends FavouritesEvent {
  const RemoveFromFavouritesEvent(this.article);

  final ArticleModel article;

  @override
  List<Object?> get props => [article];
}
