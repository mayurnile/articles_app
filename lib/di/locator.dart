import 'package:articles_app/core/core.dart';
import 'package:articles_app/core/navigation/routes.dart';
import 'package:articles_app/network/constants/constants.dart';
import 'package:articles_app/network/data/datasources/local/article_local_datasource.dart';
import 'package:articles_app/network/data/datasources/remote/article_remote_datasource.dart';
import 'package:articles_app/network/data/helpers/http_helper.dart';
import 'package:articles_app/network/data/helpers/repository_helper.dart';
import 'package:articles_app/network/data/repository_impl/articles_repository_impl.dart';
import 'package:articles_app/network/data/repository_impl/favourites_repository_impl.dart';
import 'package:articles_app/network/models/article_model.dart';
import 'package:articles_app/network/repositories/articles_repository.dart';
import 'package:articles_app/network/repositories/favourites_repository.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

final locator = GetIt.instance;

Future<void> setUpServiceLocator({required String baseUrl}) async {
  // external dependencies
  locator
    ..registerLazySingleton<Dio>(Dio.new)
    ..registerLazySingleton<DataConnectionChecker>(DataConnectionChecker.new)
    ..registerLazySingleton<AppRouter>(AppRouter.new)
    ..registerLazySingleton<HiveBox>(() => HiveBoxImpl(Hive));

  // init Hive
  await locator.get<HiveBox>().initFlutter();

  // registering type adapters
  Hive.registerAdapter(ArticleModelAdapter());

  // creating hie box
  final articleBox = await Hive.openBox<dynamic>(
    LocalStorageConstants.articleBox,
  );

  // init helpers
  locator
    ..registerLazySingleton<RepositoryHelper<dynamic>>(
      () => RepositoryHelperImpl<dynamic>(connectionChecker: locator()),
    )
    ..registerLazySingleton<HttpHelper>(
      () => HttpHelperImpl(baseURL: baseUrl, dio: locator())..initHttpClient(),
    )
    // init datasources
    ..registerLazySingleton<ArticleRemoteDatasource>(
      () => ArticleRemoteDatasource(httpHelper: locator()),
    )
    // init local data sources
    ..registerLazySingleton<ArticleLocalDataSource>(
      () => ArticleLocalDataSource(articleBox: articleBox),
    )
    // init repositories
    ..registerLazySingleton<ArticlesRepository>(
      () => ArticlesRepositoryImpl(
        articleRemoteDataSource: locator(),
        repositoryHelper: locator(),
      ),
    )
    ..registerLazySingleton<FavouritesRepository>(
      () => FavouritesRepositoryImpl(
        repositoryHelper: locator(),
        localDataSource: locator(),
      ),
    );
}
