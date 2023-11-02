import 'package:news_app/app/core/resources/data_state.dart';
import 'package:news_app/app/features/display_news/domain/entities/article.dart';

abstract class ArticleRepository {
  //Api
  Future<DataState<List<dynamic>>> getNewsArticles();
  Future<DataState<List<dynamic>>> getSearchArticles(String search);

  //Database Method

  Future<DataState<List<dynamic>>> getSavedArticles();
}
