import 'package:articles_app/core/core.dart';
import 'package:articles_app/network/constants/constants.dart';
import 'package:articles_app/network/models/article_model.dart';
import 'package:hive/hive.dart';

class ArticleLocalDataSource {
  ArticleLocalDataSource({required Box<dynamic> articleBox})
    : _articleBox = articleBox;

  final Box<dynamic> _articleBox;

  Future<List<ArticleModel>?> getAllFavourites() async {
    try {
      final getCachedFavourites =
          _articleBox.get(LocalStorageConstants.favourites)
              as List<ArticleModel>?;

      return getCachedFavourites ?? [];
    } catch (e) {
      throw CacheException(
        exception: e.toString(),
        message: 'Unable to load favourites',
      );
    }
  }

  Future<bool> addToFavourites({required ArticleModel article}) async {
    try {
      final getCachedFavourites =
          _articleBox.get(LocalStorageConstants.favourites)
              as List<ArticleModel>?;

      if (getCachedFavourites != null) {
        getCachedFavourites.add(article);
        await _articleBox.put(
          LocalStorageConstants.favourites,
          getCachedFavourites,
        );
      } else {
        final articles = <ArticleModel>[article];
        await _articleBox.put(LocalStorageConstants.favourites, articles);
      }
      return true;
    } catch (e) {
      throw CacheException(
        exception: e.toString(),
        message: 'Unable to add to favourites',
      );
    }
  }

  Future<bool> removeFromFavourites({required int articleId}) async {
    try {
      final getCachedFavourites =
          _articleBox.get(LocalStorageConstants.favourites)
              as List<ArticleModel>?;

      if (getCachedFavourites != null) {
        getCachedFavourites.removeWhere((element) => element.id == articleId);
        await _articleBox.put(
          LocalStorageConstants.favourites,
          getCachedFavourites,
        );
      }
      return true;
    } catch (e) {
      throw CacheException(
        exception: e.toString(),
        message: 'Unable to remove from favourites',
      );
    }
  }
}
