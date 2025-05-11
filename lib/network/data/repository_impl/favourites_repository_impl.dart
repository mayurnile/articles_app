import 'package:articles_app/core/core.dart';
import 'package:articles_app/network/data/datasources/local/article_local_datasource.dart';
import 'package:articles_app/network/data/helpers/repository_helper.dart';
import 'package:articles_app/network/models/models.dart';
import 'package:articles_app/network/repositories/favourites_repository.dart';
import 'package:dartz/dartz.dart';

class FavouritesRepositoryImpl implements FavouritesRepository {
  FavouritesRepositoryImpl({
    required RepositoryHelper<dynamic> repositoryHelper,
    required ArticleLocalDataSource localDataSource,
  }) : _repositoryHelper = repositoryHelper,
       _localDataSource = localDataSource;

  final RepositoryHelper<dynamic> _repositoryHelper;
  final ArticleLocalDataSource _localDataSource;

  /// Get all favourite articles
  ///
  /// Returns a list of favourite article IDs or a failure
  @override
  Future<Either<Failure, List<ArticleModel>>> getFavourites() async {
    final failureOrSuccess = await _repositoryHelper.callAPI(() async {
      final favourites = await _localDataSource.getAllFavourites();
      return favourites ?? [];
    });

    return failureOrSuccess.fold(
      Left<Failure, List<ArticleModel>>.new,
      (r) => Right<Failure, List<ArticleModel>>(r as List<ArticleModel>),
    );
  }

  /// Add an article to favourites
  ///
  /// [article] - The Article to add to favourites
  /// Returns true if the article was added successfully, false otherwise
  @override
  Future<Either<Failure, bool>> addToFavourites({
    required ArticleModel article,
  }) async {
    final failureOrSuccess = await _repositoryHelper.callAPI(() async {
      final result = await _localDataSource.addToFavourites(article: article);
      return result;
    });

    return failureOrSuccess.fold(
      Left<Failure, bool>.new,
      (r) => Right<Failure, bool>(r as bool),
    );
  }

  /// Remove an article from favourites
  ///
  /// [articleId] - The ID of the article to remove from favourites
  /// Returns true if the article was removed successfully, false otherwise
  @override
  Future<Either<Failure, bool>> removeFromFavourites({
    required int articleId,
  }) async {
    final failureOrSuccess = await _repositoryHelper.callAPI(() async {
      final result = await _localDataSource.removeFromFavourites(
        articleId: articleId,
      );
      return result;
    });

    return failureOrSuccess.fold(
      Left<Failure, bool>.new,
      (r) => Right<Failure, bool>(r as bool),
    );
  }
}
