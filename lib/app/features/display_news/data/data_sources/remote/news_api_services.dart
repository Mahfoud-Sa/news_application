import 'package:dio/dio.dart';
import 'package:news_app/app/core/constants/constants.dart';
import 'package:news_app/app/core/resources/data_state.dart';
import 'package:news_app/app/features/display_news/data/modules/article.dart';
import 'package:retrofit/dio.dart';
import 'package:build_daemon/constants.dart';

class NewsApiService {
  var dio = Dio();
//dio.options.connect
  //factory NewsApiService(Dio dio, {String baseUrl}) = _NewsApiServices;

  //get all articles
  Future<Response> getNewsArticles() async {
    Response response = await dio.get('${newsAPIBaseURL}/everything',
        queryParameters: {'apiKey': apiKey, 'q': 'donkey'});
    //print(response);
    return response;
  }

  // search article
  Future<Response> SearchArticles(String search) async {
    Response response = await dio.get('${newsAPIBaseURL}/everything',
        queryParameters: {'apiKey': apiKey, 'q': search});
    return response;
  }
}
