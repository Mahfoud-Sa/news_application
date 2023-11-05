import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:news_app/app/core/resources/data_state.dart';
import 'package:news_app/app/features/display_news/data/data_sources/local/loca_news_api_services.dart';
import 'package:news_app/app/features/display_news/data/modules/article.dart';
import 'package:news_app/app/features/display_news/data/repository/article_repository_impl.dart';
import 'package:news_app/app/features/display_news/domain/repository/article_repository.dart';
import 'package:news_app/app/features/display_news/domain/usecase/get_article.dart';
import 'package:news_app/app/features/display_news/presentation/bloc/article_event.dart';
import 'package:news_app/app/features/display_news/presentation/bloc/article_state.dart';
import 'package:dio/dio.dart';

class RemoteArticleBloc extends Bloc<RemoteArticleEvent, RemoteArticleState> {
  //int counter = 0;
  // GetArticleUseCase _getArticleUseCase = GetArticleUseCase();
  //final GetArticleUseCase _getarticleUseCase;
  RemoteArticleBloc() : super(RemoteArticlesLoading()) {
    on<RemoteArticleEvent>(_ongetArticles);
  }

  FutureOr<void> _ongetArticles(
      RemoteArticleEvent event, Emitter<RemoteArticleState> emit) async {
    ArticleRepositoryImpl arti = ArticleRepositoryImpl();
    emit(RemoteArticlesLoading());
    if (event is GetAllArticles) {
      var articles = await arti.getNewsArticles();
      if (articles is DataSuccess) {
        emit(RemoteArticlesDone(articles.data!));
      } else if (articles is DataFailed) {
        emit(RemoteArticlesException(articles.error));
      } else {
        emit(RemoteArticlesLoading());
      }
    } else if (event is GetSearchArticles) {
      var articles = await arti.getSearchArticles(event.search);

      if (articles is DataSuccess) {
        emit(RemoteArticlesDone(articles.data!));
      } else if (articles is DataFailed) {
        emit(RemoteArticlesException(articles.error));
      } else {
        emit(RemoteArticlesLoading());
      }
    } else if (event is GetCategoryArticles) {
      var articles = await arti.getSearchArticles(event.category);

      if (articles is DataSuccess) {
        emit(RemoteArticlesDone(articles.data!));
      } else if (articles is DataFailed) {
        emit(RemoteArticlesException(articles.error));
      } else {
        emit(RemoteArticlesLoading());
      }
    }
  }
}
