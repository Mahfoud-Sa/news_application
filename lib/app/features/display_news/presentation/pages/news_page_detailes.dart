import 'package:flutter/material.dart';
import 'package:news_app/app/features/display_news/data/modules/article.dart';

class NewsDetailes extends StatelessWidget {
  //final ArticleModel articleModel;
  const NewsDetailes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [Text('News title'), Text('Contenr')],
      ),
    );
  }
}
