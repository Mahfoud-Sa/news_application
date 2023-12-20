import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:news_app/app/core/resources/app_database.dart';
import 'package:news_app/app/features/display_news/data/modules/article.dart';
import 'package:news_app/app/features/display_news/domain/entities/article.dart';
import 'package:news_app/app/features/display_news/presentation/pages/homePage.dart';
import 'package:news_app/app/features/favorite_news/data/data_source/DAO/article_dao.dart';
import 'package:news_app/app/features/favorite_news/data/data_source/DAO/article_dao.dart';
import 'package:news_app/app/features/favorite_news/data/data_source/DAO/article_dao.dart';
import 'package:news_app/app/features/favorite_news/data/data_source/DAO/article_dao.dart';
import 'package:news_app/app/features/favorite_news/presentation/widgets/news_card_widget.dart';
import 'package:news_app/initialization_dependencies.dart';
import 'package:sqflite/sqflite.dart';

class FavoritePage extends StatelessWidget {
  final List<ArticleModel> articles = [];
  FavoritePage({super.key});
  Future<List<ArticleModel>> getArticles() async {
    var _appDataBaseServices = getIt.get<AppDataBaseServices>();
    _appDataBaseServices.articleDao.getAll();
    return await _appDataBaseServices.articleDao.getAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: getArticles(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return FavoriteNewsCardWidget(article: snapshot.data![index]);
              },
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
