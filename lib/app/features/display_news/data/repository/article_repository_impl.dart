import 'dart:io';

import 'package:news_app/app/core/constants/constants.dart';
import 'package:news_app/app/core/resources/data_state.dart';
import 'package:news_app/app/features/display_news/data/data_sources/local/loca_news_api_services.dart';
import 'package:news_app/app/features/display_news/data/data_sources/remote/news_api_services.dart';
import 'package:news_app/app/features/display_news/data/modules/article.dart';
import 'package:news_app/app/features/display_news/domain/entities/article.dart';
import 'package:news_app/app/features/display_news/domain/repository/article_repository.dart';
import 'package:dio/dio.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final NewsApiService _newsApiService = NewsApiService();
  //ArticleRepositoryRepositoryImpl(this._newsApiService);

  @override
  Future<DataState<List<dynamic>>> getNewsArticles() async {
    Response httpResponse = await _newsApiService.getNewsArticles();
    print(httpResponse);

    if (httpResponse.statusCode == 200) {
      var articles = httpResponse.data['articles']
          .map((json) => ArticleModel.fromJson(json))
          .toList();
      return DataSuccess(articles);
    } else {
      return DataFailed(DioException(
          error: httpResponse.statusMessage,
          response: httpResponse,
          type: DioExceptionType.badResponse,
          requestOptions: httpResponse.requestOptions));
    }
  }

  @override
  Future<DataState<List<dynamic>>> getSavedArticles() async {
    var articles = await LocalNewsApiServices().getArticleNews();
    return articles;
  }

  @override
  Future<DataState<List>> getSearchArticles(String search) async {
    Response httpResponse = await _newsApiService.SearchArticles(search);
    print(httpResponse);

    if (httpResponse.statusCode == 200) {
      var articles = httpResponse.data['articles']
          .map((json) => ArticleModel.fromJson(json))
          .toList();
      return DataSuccess(articles);
    } else {
      return DataFailed(DioException(
          error: httpResponse.statusMessage,
          response: httpResponse,
          type: DioExceptionType.badResponse,
          requestOptions: httpResponse.requestOptions));
    }
  }
}
