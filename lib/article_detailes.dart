import 'package:flutter/material.dart';
import 'package:news_app/app/features/display_news/data/Modules/article_model.dart';

class ArticleDetailes extends StatelessWidget {
  final Article article;
  ArticleDetailes({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(article.title!),
        Text(article.description!),
      ],
    );
  }
}
