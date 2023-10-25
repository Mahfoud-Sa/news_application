import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:news_app/app/core/resources/data_state.dart';
import 'package:news_app/app/features/display_news/data/modules/article.dart';
import 'package:news_app/app/features/display_news/data/repository/article_repository_impl.dart';
import 'package:news_app/app/features/display_news/domain/repository/article_repository.dart';
import 'package:news_app/app/features/display_news/domain/usecase/get_article.dart';
import 'package:news_app/app/features/display_news/presentation/bloc/article_event.dart';
import 'package:news_app/app/features/display_news/presentation/bloc/article_state.dart';
import 'package:dio/dio.dart';

class RemoteArticleBloc extends Bloc<RemoteArticleEvent, RemoteArticleState> {
  int counter = 0;
  GetArticleUseCase _getArticleUseCase = GetArticleUseCase();
  //final GetArticleUseCase _getarticleUseCase;
  RemoteArticleBloc() : super(RemoteArticlesLoading()) {
    on<RemoteArticleEvent>(_ongetArticles);
  }

  FutureOr<void> _ongetArticles(
      RemoteArticleEvent event, Emitter<RemoteArticleState> emit) async {
    ArticleRepositoryImpl arti = ArticleRepositoryImpl();

    var articles = await arti.getNewsArticles();
    //print(articles.runtimeType);
    //var hh = await _getArticleUseCase();
    //print(hh);
    // var dio = Dio();
    // // var arti = ArticleRepository().getNewsArticles();
    // final response = await dio.get(
    //     'https://newsapi.org/v2/everything?q=bitcoin&apiKey=9b4791ffa29b4365a7db0cc3b0a97843');
    // //print(response.data['articles']);
    // //ArticleModel article =
    // //ArticleModel.fromJson(response.data['articles'][0]);
    // var httpResponse = response.data['articles']
    //     .map((json) => ArticleModel.fromJson(json))
    //     .toList();

    emit(RemoteArticlesDone(articles.data!));
  }
}
