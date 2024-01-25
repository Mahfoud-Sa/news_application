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
        //  'publishedAt': article.publishedAt!.toString(),
        'content': article.content,
      },
    );
  }

  Future<ArticleModel?> get(ArticleEntity article) async {
    var response = await _AppDataBase!.query('articles', columns: [
      "source_id",
      "source_name",
      "title",
      "author",
      "description",
      "url",
      "urlToImage",
      "content",
    ], where: """
      source_id=? and
      source_name=?and
      title=?and
      description=?and
      url=?and
      urlToImage=?and
      content=?
        """, whereArgs: [
      article.source!.id!,
      article.source!.name!,
      article.title,
      article.descripution,
      article.url,
      article.urlToImage,
      //   article.publishedAt,
      article.content
    ]);
    List<ArticleModel> articles =
        response.map((json) => ArticleModel.fromLocalDataBase(json)).toList();
    if (articles.length == 1) {
      return articles[0];
    }
  }

  Future<List<ArticleModel>> getAll() async {
    List<Map<String, Object?>> responsive =
        await _AppDataBase.rawQuery("SELECT articles.* FROM articles");

    List<ArticleModel> articles =
        responsive.map((json) => ArticleModel.fromLocalDataBase(json)).toList();

    return articles;
  }

  //delete
  Future<int> deletetArticle(int id) async {
    return await _AppDataBase!
        .delete("articles", where: "id=?", whereArgs: [id]);
  }
}
