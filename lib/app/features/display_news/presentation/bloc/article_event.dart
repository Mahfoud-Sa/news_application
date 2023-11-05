import 'package:dio/dio.dart';
import 'package:news_app/app/core/resources/data_state.dart';
import 'package:news_app/app/features/display_news/data/modules/article.dart';
import 'package:news_app/app/features/display_news/presentation/bloc/article_state.dart';

abstract class RemoteArticleEvent {
  const RemoteArticleEvent();
}

class GetAllArticles extends RemoteArticleEvent {
  const GetAllArticles();
}

class GetCategoryArticles extends RemoteArticleEvent {
  final String category;

  const GetCategoryArticles(this.category);
}

class GetSearchArticles extends RemoteArticleEvent {
  final String search;
  final String category;
  const GetSearchArticles(this.search, this.category);
}
