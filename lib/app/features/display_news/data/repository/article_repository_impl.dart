import 'dart:io';

import 'package:news_app/app/core/constants/constants.dart';
import 'package:news_app/app/core/resources/data_state.dart';
import 'package:news_app/app/features/display_news/data/data_sources/remote/news_api_services.dart';
import 'package:news_app/app/features/display_news/data/modules/article.dart';
import 'package:news_app/app/features/display_news/domain/entities/article.dart';
import 'package:news_app/app/features/display_news/domain/repository/article_repository.dart';
import 'package:dio/dio.dart';

class ArticleRepositoryRepositoryImpl {
  // final NewsApiService _newsApiService;
  //ArticleRepositoryRepositoryImpl(this._newsApiService);
  //@override
  Future<DataState<List<ArticleModel>>> getNewsArticles() async {
    var dio = Dio();

    final response = await dio.get(
        'https://newsapi.org/v2/everything?q=bitcoin&apiKey=9b4791ffa29b4365a7db0cc3b0a97843');
    //print(response.data['articles']);
    //ArticleModel article =
    //ArticleModel.fromJson(response.data['articles'][0]);
    var httpResponse = response.data['articles']
        .map((json) => ArticleModel.fromJson(json))
        .toList();
    // final httpResponse = await _newsApiService.getNewsArticles(
    // apiKey: newsAPIBaseURL,
    //  country: country,
    //  category: category,
    //  );
    var c = print(response.statusMessage == 'OK');
    if (response.statusMessage == 'OK') {
      print(response.data);
      return DataSuccess(httpResponse);
    } else {
      return DataFailed(DioException(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          type: DioExceptionType.badResponse,
          requestOptions: httpResponse.response.requestOptions));
    }
  }
}
