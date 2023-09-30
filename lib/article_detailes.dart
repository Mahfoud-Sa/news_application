import 'package:flutter/material.dart';
import 'package:news_app/app/features/display_news/data/modules/article.dart';

class ArticleDetailes extends StatelessWidget {
  final ArticleModel article;
  ArticleDetailes({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text('article.!'),
        ],
      ),
    );
  }
}
