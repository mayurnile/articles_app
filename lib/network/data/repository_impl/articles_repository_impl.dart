import 'package:articles_app/core/core.dart';
import 'package:articles_app/network/data/datasources/remote/article_remote_datasource.dart';
import 'package:articles_app/network/data/helpers/repository_helper.dart';
import 'package:articles_app/network/models/models.dart';
import 'package:articles_app/network/repositories/articles_repository.dart';
import 'package:dartz/dartz.dart';

class ArticlesRepositoryImpl implements ArticlesRepository {
  ArticlesRepositoryImpl({
    required ArticleRemoteDatasource articleRemoteDataSource,
    required RepositoryHelper<dynamic> repositoryHelper,
  }) : _remoteDatasource = articleRemoteDataSource,
       _repositoryHelper = repositoryHelper;

  final ArticleRemoteDatasource _remoteDatasource;
  final RepositoryHelper<dynamic> _repositoryHelper;

  /// Get all articles
  ///
  /// Returns a list of articles or a failure
  @override
  Future<Either<Failure, List<ArticleModel>>> getArticles() async {
    final failureOrSuccess = await _repositoryHelper.callAPI(() async {
      final data = await _remoteDatasource.getAllArticles();
      return data;
    });

    return failureOrSuccess.fold(
      Left<Failure, List<ArticleModel>>.new,
      (r) => Right<Failure, List<ArticleModel>>(r as List<ArticleModel>),
    );
  }

  /// Search articles by query
  ///
  /// [query] - The search term to look for in articles
  /// Returns a list of matching articles or a failure
  @override
  Future<Either<Failure, List<ArticleModel>>> searchArticles(
    String query,
  ) async {
    final failureOrSuccess = await _repositoryHelper.callAPI(
      () async {
        final data = await _remoteDatasource.searchArticles(query);
        return data;
      },
      checkOfflineDB: false, // Typically search doesn't use cached data
    );

    return failureOrSuccess.fold(
      Left<Failure, List<ArticleModel>>.new,
      (r) => Right<Failure, List<ArticleModel>>(r as List<ArticleModel>),
    );
  }
}
