import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:news_app/app/core/resources/app_database.dart';
import 'package:news_app/app/features/display_news/data/modules/article.dart';
import 'package:news_app/app/features/display_news/domain/entities/article.dart';
import 'package:news_app/initialization_dependencies.dart';
import 'package:sqflite/sqflite.dart';

class FavoriteBtn extends StatefulWidget {
  final ArticleModel articleEntity;
  const FavoriteBtn({super.key, required this.articleEntity});

  @override
  State<FavoriteBtn> createState() => _FavoriteBtnState();
}

class _FavoriteBtnState extends State<FavoriteBtn> {
  bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: isFavorite ? Colors.red : null,
      ),
      onPressed: () async {
        setState(() {
          isFavorite = !isFavorite;
        });

        var _AppDataBaseServices = await getIt.get<AppDataBaseServices>();
        _AppDataBaseServices.articleDao.insertArticle(widget.articleEntity);
      },
    );
  }
}
