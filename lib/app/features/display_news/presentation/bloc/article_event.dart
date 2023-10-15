import 'package:dio/dio.dart';
import 'package:news_app/app/core/resources/data_state.dart';
import 'package:news_app/app/features/display_news/data/modules/article.dart';
import 'package:news_app/app/features/display_news/presentation/bloc/article_state.dart';

abstract class RemoteArticleEvent {
  const RemoteArticleEvent();
}

class GetArticles extends RemoteArticleEvent {
  const GetArticles();
}


// void onGetArticle() async {
//     Dio dio = Dio();
//     final response = await dio.get(
//         'https://newsapi.org/v2/everything?q=bitcoin&apiKey=9b4791ffa29b4365a7db0cc3b0a97843');
//     //DataSuccess(response.data);
//     //print(response.data['articles']);
//     //ArticleModel article = ArticleModel.fromJson(response.data['articles'][0]);
//     var articles = response.data['articles']
//         .map((json) => ArticleModel.fromJson(json))
//         .toList();
//     print(articles.data);
//     final datastate = DataFailed(articles.data); // _getarticleUseCase();
//   }