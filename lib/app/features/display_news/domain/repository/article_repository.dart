import 'package:news_app/app/core/resources/data_state.dart';
import 'package:news_app/app/features/display_news/domain/entities/article.dart';

abstract class ArticleRepository {
  Future<DataState<List<ArticleEntity>>> getNewsArticles();
}
