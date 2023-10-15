import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:news_app/app/core/resources/data_state.dart';
import 'package:news_app/app/features/display_news/data/modules/article.dart';
import 'package:news_app/app/features/display_news/data/repository/article_repository_impl.dart';
import 'package:news_app/app/features/display_news/domain/usecase/get_article.dart';
import 'package:news_app/app/features/display_news/presentation/bloc/article_event.dart';
import 'package:news_app/app/features/display_news/presentation/bloc/article_state.dart';
import 'package:dio/dio.dart';

class RemoteArticleBloc extends Bloc<RemoteArticleEvent, RemoteArticleState> {
  int counter = 0;

  //final GetArticleUseCase _getarticleUseCase;
  RemoteArticleBloc() : super(RemoteArticlesLoading()) {
    on<RemoteArticleEvent>(((event, emit) async {
      ArticleRepositoryRepositoryImpl getnewa =
          ArticleRepositoryRepositoryImpl();
      final response = getnewa.getNewsArticles();
      //api call
      // Dio dio = Dio();
      // final response = await dio.get(
      //     'https://newsapi.org/v2/everything?q=bitcoin&apiKey=9b4791ffa29b4365a7db0cc3b0a97843');

      print(response.toString());
      print(response is DataFailed);
      if (response is DataSuccess) {
        //response.error
        emit(RemoteArticlesException(response.toString()));
      }
      if (response is DataSuccess) {
        emit(RemoteArticlesDone(10));
      }

      // if (event is GetArticles) {

      // } else {
      //   emit(RemoteArticlesLoading());
      // }
    }));
  }
}
