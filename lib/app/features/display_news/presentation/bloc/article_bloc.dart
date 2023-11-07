import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/app/core/resources/data_state.dart';
import 'package:news_app/app/features/display_news/data/repository/article_repository_impl.dart';
import 'package:news_app/app/features/display_news/presentation/bloc/article_event.dart';
import 'package:news_app/app/features/display_news/presentation/bloc/article_state.dart';

class RemoteArticleBloc extends Bloc<RemoteArticleEvent, RemoteArticleState> {
  RemoteArticleBloc() : super(RemoteArticlesLoading()) {
    on<RemoteArticleEvent>(_ongetArticles);
  }

  FutureOr<void> _ongetArticles(
      RemoteArticleEvent event, Emitter<RemoteArticleState> emit) async {
    ArticleRepositoryImpl arti = ArticleRepositoryImpl();

    emit(RemoteArticlesLoading());
    if (event is GetSearchArticles) {
      var articles = await arti.getSearchArticles(event.search);
      if (articles is DataSuccess && articles.data!.isNotEmpty) {
        emit(RemoteArticlesDone(articles.data!));
      } else if (articles is DataFailed) {
        emit(RemoteArticlesException(articles.error));
      } else {
        emit(RemoteArticlesLoading());
      }
    } else {
      //emit(RemoteArticlesException('Nothing to show'));
    }
  }
}
