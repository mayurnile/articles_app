import 'package:articles_app/core/core.dart';
import 'package:articles_app/network/models/models.dart';
import 'package:dartz/dartz.dart';

abstract class ArticlesRepository {
  /// Get all articles
  ///
  /// Returns a list of articles or a failure
  Future<Either<Failure, List<ArticleModel>>> getArticles();

  /// Search articles by query
  ///
  /// [query] - The search term to look for in articles
  /// Returns a list of matching articles or a failure
  Future<Either<Failure, List<ArticleModel>>> searchArticles(String query);
}
