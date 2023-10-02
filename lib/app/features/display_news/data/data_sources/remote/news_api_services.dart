import 'package:news_app/app/core/constants/constants.dart';
import 'package:news_app/app/features/display_news/data/modules/article.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:dio/dio.dart';

part 'news_api_service.g.dart';

@RestApi(baseUrl: newsAPIBaseURL)
abstract class NewsApiService {
  factory NewsApiService(Dio dio) = _NewsApiServices;

  @GET('/top-headlings')
  Future<HttpResponse<List<ArticleModel>>>getNewsArticles(
    {
      @Query('apiKey') String ? apiKey,
      @Query('country') String ? country,
      @Query('category') String ? category,
     
      
    }
  )

}
