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

class GetSportArticles extends RemoteArticleEvent {
  const GetSportArticles();
}

class GetAnimalesArticles extends RemoteArticleEvent {
  const GetAnimalesArticles();
}

class GetTechnologyArticles extends RemoteArticleEvent {
  const GetTechnologyArticles();
}

class GetHealthArticles extends RemoteArticleEvent {
  const GetHealthArticles();
}

class GetFundsArticles extends RemoteArticleEvent {
  const GetFundsArticles();
}

class GetSearchArticles extends RemoteArticleEvent {
  final String search;
  const GetSearchArticles(this.search);
}
