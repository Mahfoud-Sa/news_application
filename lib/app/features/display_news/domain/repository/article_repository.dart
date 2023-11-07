import 'package:news_app/app/core/resources/data_state.dart';

abstract class ArticleRepository {
  //Api

  Future<DataState<List<dynamic>>> getSearchArticles(String search);
}
