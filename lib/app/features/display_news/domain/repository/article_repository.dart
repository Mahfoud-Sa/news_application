import 'package:news_app/app/core/resources/data_state.dart';
import 'package:news_app/app/features/display_news/domain/entities/article.dart';

abstract class ArticleRepository {
  //Api

  Future<DataState<List<dynamic>>> getSearchArticles(String search);
  Future<DataState<List<dynamic>>> getSavedArticles();
  Future<int> dropArticle(int index);
  Future<int> saveArticle(ArticleEntity article);
}
