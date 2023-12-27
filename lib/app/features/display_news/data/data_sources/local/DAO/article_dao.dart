import 'package:news_app/app/features/display_news/data/modules/article.dart';
import 'package:news_app/app/features/display_news/data/modules/source.dart';
import 'package:news_app/app/features/display_news/domain/entities/article.dart';
import 'package:news_app/initialization_dependencies.dart';
import 'package:sqflite/sqflite.dart';

class ArticleDao {
  final Database _AppDataBase;

  ArticleDao({required Database AppDataBase}) : _AppDataBase = AppDataBase;

  //insert
  Future<int> insertArticle(ArticleEntity article) async {
    // await _AppDataBase.insert(
    //   'sources',
    //   {
    //     'id': article.source!.id,
    //     'name': article.source!.name,
    //     //'date': DateTime.now().toIso8601String()
    //   },
    // );
    // var sourceId =
    //     await _AppDataBase.rawQuery("SELECT sources.sourceId from sources");
    // print(sourceId);
    return await _AppDataBase.insert(
      'articles',
      {
        "source_id": article.source!.id,
        "source_name": article.source!.name,
        'author': article.author,
        'title': article.title,
        'description': article.descripution,
        'url': article.url,
        'urlToImage': article.urlToImage,
        'publishedAt': article.publishedAt!.toIso8601String(),
        'content': article.content,
      },
    );
  }

  Future<List<ArticleModel>> getAll() async {
    List<Map<String, Object?>> responsive =
        await _AppDataBase.rawQuery("SELECT articles.* FROM articles ;");
    // List<Map<String, Object?>> sources =
    //     await _AppDataBase.rawQuery("SELECT sources.*  FROM sources");

    // print(articles);
    // print(articles);
    // print(sources);
    List<ArticleModel> articles =
        responsive.map((json) => ArticleModel.fromLocalDataBase(json)).toList();
    // print(articles_);
    // print(articles_[0].source = SourceModel.fromJson(sources[0]));
    // print(articles_);
    // print(articles);
    return articles;
  } // "SELECT articles.*, sources.* FROM articles INNER JOIN sources ON articles.source = sources.id;");

  //delete
  Future<int> deletetArticle(int id) async {
    return await _AppDataBase!
        .delete("articles", where: "id=?", whereArgs: [id]);
  }
  //get
  // Future<List<ArticleEntity>> getArticles() async {
  //   List<dynamic> response = await _AppDataBase!.rawQuery(
  //       "SELECT articles.*, sources.* FROM articles INNER JOIN sources ON articles.source = sources.id;");

  //   response.data['articles']
  //       .map((json) => ArticleModel.fromJson(json))
  //       .toList();
  // }
}
