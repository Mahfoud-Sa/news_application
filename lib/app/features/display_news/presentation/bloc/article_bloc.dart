import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/app/core/resources/data_state.dart';
import 'package:news_app/app/features/display_news/data/repository/article_repository_impl.dart';
import 'package:news_app/app/features/display_news/presentation/bloc/article_event.dart';
import 'package:news_app/app/features/display_news/presentation/bloc/article_state.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  ArticleBloc() : super(ArticlesLoading()) {
    on<ArticleEvent>(_ongetArticles);
  }

  FutureOr<void> _ongetArticles(
      ArticleEvent event, Emitter<ArticleState> emit) async {
    ArticleRepositoryImpl arti = ArticleRepositoryImpl();

    if (event is GetSearchArticles) {
      emit(ArticlesLoading());
      var articles = await arti.getSearchArticles(event.search);
      if (articles is DataSuccess && articles.data!.isNotEmpty) {
        emit(ArticlesDone(articles.data!));
      } else if (articles is DataFailed) {
        emit(ArticlesException(articles.error));
      }
    } else if (event is GetSavedArticles) {
      emit(ArticlesLoading());
      var articles = await arti.getSavedArticles();
      emit(ArticlesDone(articles.data!));
    } else if (event is SaveArticle) {
      // emit(ArticlesLoading());
      await arti.saveArticle(event.articel);
      //  await arti.getSavedArticles();

      // emit(ArticlesDone(articles.data!));
    } else if (event is DropArticle) {
      emit(ArticlesLoading());
      await arti.dropArticle(event.index);
      var articles = await arti.getSavedArticles();
      // print(articles.data);
      emit(ArticlesDone(articles.data!));
    }
  }
}
