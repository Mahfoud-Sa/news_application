import 'package:dio/dio.dart';
import 'package:news_app/app/core/resources/app_database.dart';
import 'package:news_app/app/core/resources/data_state.dart';
import 'package:news_app/app/features/display_news/data/data_sources/remote/news_api_services.dart';
import 'package:news_app/app/features/display_news/data/modules/article.dart';
import 'package:news_app/app/features/display_news/domain/entities/article.dart';
import 'package:news_app/app/features/display_news/domain/repository/article_repository.dart';
import 'package:news_app/initialization_dependencies.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final NewsApiService _newsApiService = NewsApiService();
  final _AppDataBaseServices = getIt.get<AppDataBaseServices>();

  @override
  Future<DataState<List>> getSearchArticles(String search) async {
    DataState httpResponse = await _newsApiService.searchArticles(search);

    if (httpResponse is DataSuccess) {
      var articles = httpResponse.data['articles']
          .map((json) => ArticleModel.fromJson(json))
          .toList();

      return DataSuccess(articles);
    } else {
      return DataFailed(httpResponse.error);
    }
  }

  Future<DataState<List>> getSavedArticles() async {
    var httpResponse = await _AppDataBaseServices.articleDao.getAll();
    return DataSuccess(httpResponse);
    // if (httpResponse is DataSuccess) {

    // } else {
    //   return DataFailed(DioException(
    //       error: 'error fetching data',
    //       type: DioExceptionType.badResponse,
    //       requestOptions: RequestOptions()));
    // }
  }

  Future<int> dropArticle(int index) async {
    return await _AppDataBaseServices.articleDao.deletetArticle(index);
  }

  Future<int> saveArticle(ArticleEntity article) async {
    return await _AppDataBaseServices.articleDao.insertArticle(article);
  }
}
