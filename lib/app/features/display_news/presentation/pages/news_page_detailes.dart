import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/app/features/display_news/data/modules/article.dart';

class NewsDetailes extends StatelessWidget {
  final ArticleModel article;
  const NewsDetailes({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          CachedNetworkImage(
            imageUrl: article.urlToImage!,
            fit: BoxFit.fill,
            height: 200,
            //width: 300,
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) =>
                Image.asset('assets/images/error_imag.jpg'),
          ),
          Text(
            article.title.toString(),
            style: TextStyle(fontSize: 25),
          ),
          Text(
            article.content.toString(),
            style: TextStyle(fontSize: 18),
          ),
          Text(article.descripution.toString()),
          Text(article.author.toString()),
          Text(article.source.toString()),
          Text(article.url.toString()),
        ],
      ),
    );
  }
}
