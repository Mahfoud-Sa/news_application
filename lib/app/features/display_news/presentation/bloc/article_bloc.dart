import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/app/core/resources/data_state.dart';
import 'package:news_app/app/core/widgets/toast_message.dart';
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
    var articles = null;
    if (event is GetSearchArticles) {
      emit(ArticlesLoading());
      articles = await arti.getSearchArticles(event.search);
      if (articles is DataSuccess && articles.data!.isNotEmpty) {
        emit(ArticlesDone(articles.data!));
      } else if (articles is DataFailed) {
        emit(ArticlesException(articles.error));
      } //  else {
      //   emit(ArticlesException(articles.error));
      // }
    } else if (event is GetSavedArticles) {
      emit(ArticlesLoading());
      var articles = await arti.getSavedArticles();
      emit(ArticlesDone(articles.data!));
    } else if (event is SaveArticle) {
      //
      int state = await arti.saveArticle(event.articel);
      if (state != 0) {
        ToastMessage().SusseccMessage('تمت اضافته للمفضلة');
      } else {
        ToastMessage().Infoessage('هذه المقالة مضافة مسبقا');
      }

      // Fluttertoast.showToast(
      //     msg: state.toString(),
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.CENTER,
      //     timeInSecForIosWeb: 1,
      //     backgroundColor: Colors.red,
      //     textColor: Colors.white,
      //     fontSize: 16.0);

      //  Toast.show('تمت إضافته للمفضلة');
      // if (state == 0) {
      //   Toast.show('this article is allready exisit');
      // } else {
      //   Toast.show('this article saved susseflly',
      //       duration: Toast.lengthShort, gravity: Toast.bottom);
      // }
      //  await arti.getSavedArticles();

      // emit(MessageDone(state.toString()));
      // emit(ArticlesDone(articles.data));
    } else if (event is DropArticle) {
      //emit(ArticlesLoading());
      await arti.dropArticle(event.index);

      ToastMessage().SusseccMessage('تم حذف المقالة بنجاح');

      var articles = await arti.getSavedArticles();
      // print(articles.data);
      emit(ArticlesDone(articles.data!));
    }
  }
}
