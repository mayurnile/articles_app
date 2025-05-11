import 'package:articles_app/core/core.dart';
import 'package:articles_app/network/models/models.dart';
import 'package:dartz/dartz.dart';

abstract class FavouritesRepository {
  /// Get all favourite articles
  ///
  /// Returns a list of favourite articles or a failure
  Future<Either<Failure, List<ArticleModel>>> getFavourites();

  /// Add an article to favourites
  ///
  /// [article] - The Article to add to favourites
  /// Returns true if the article was added successfully, false otherwise
  Future<Either<Failure, bool>> addToFavourites({
    required ArticleModel article,
  });

  /// Remove an article from favourites
  ///
  /// [articleId] - The ID of the article to remove from favourites
  /// Returns true if the article was removed successfully, false otherwise
  Future<Either<Failure, bool>> removeFromFavourites({required int articleId});
}
