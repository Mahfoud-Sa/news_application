import 'package:news_app/app/features/display_news/domain/entities/article.dart';

abstract class ArticleEvent {
  const ArticleEvent();
}

class GetAllArticles extends ArticleEvent {
  const GetAllArticles();
}

class GetSavedArticles extends ArticleEvent {
  const GetSavedArticles();
}

class DropArticle extends ArticleEvent {
  final int index;
  const DropArticle(this.index);
}

class SaveArticle extends ArticleEvent {
  final ArticleEntity articel;
  const SaveArticle(this.articel);
}

class GetSearchArticles extends ArticleEvent {
  final String search;

  const GetSearchArticles(this.search);
}
