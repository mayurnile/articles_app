import 'package:articles_app/core/core.dart';
import 'package:articles_app/network/constants/constants.dart';
import 'package:articles_app/network/data/helpers/http_helper.dart';
import 'package:articles_app/network/models/models.dart';

class ArticleRemoteDatasource {
  const ArticleRemoteDatasource({required HttpHelper httpHelper})
    : _httpHelper = httpHelper;

  final HttpHelper _httpHelper;

  /// Fetches all articles from the remote API
  Future<List<ArticleModel>> getAllArticles() async {
    try {
      final response = await _httpHelper.get(EndPoints.articles);
      if (response.statusCode == 200) {
        final articleResponse =
            (response.data as List)
                .map((e) => ArticleModel.fromJson(e as Map<String, dynamic>))
                .toList();

        return articleResponse;
      } else {
        throw const ServerException();
      }
    } catch (e) {
      rethrow;
    }
  }

  /// Searches for articles by query
  Future<List<ArticleModel>> searchArticles(String query) async {
    try {
      final response = await _httpHelper.get(EndPoints.articles);

      if (response.statusCode == 200) {
        final articleResponse =
            (response.data as List)
                .map((e) => ArticleModel.fromJson(e as Map<String, dynamic>))
                .toList();

        if (query.isEmpty) {
          return articleResponse;
        } else {
          return articleResponse.where((article) {
            final lowercaseQuery = query.toLowerCase();

            return article.title.toLowerCase().contains(lowercaseQuery);

            // return article.title.toLowerCase().contains(lowercaseQuery) ||
            //     (article.content.toLowerCase().contains(lowercaseQuery));
          }).toList();
        }
      } else {
        throw const ServerException();
      }
    } catch (e) {
      rethrow;
    }
  }
}
