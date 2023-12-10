import 'package:news_app/app/features/display_news/data/modules/article.dart';
import 'package:news_app/app/features/display_news/domain/entities/article.dart';

abstract class ArticleDao {
//insert
  Future<void> insertArticle(ArticleModel article);

  //delete
  Future<void> deletetArticle(int id);
  //get
  Future<List<ArticleEntity>> getArticles();
}
