import 'dart:io';

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
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(
            imageUrl: article.urlToImage!,
            fit: BoxFit.fill,
            height: 200,
            //width: 300,
            placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) =>
                Image.asset('assets/images/error_imag.jpg'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(
              article.title.toString(),
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              article.content.toString(),
              style: const TextStyle(fontSize: 14),
            ),
          ),
          //Text(article.descripution.toString()),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              "Author: ${article.author}",
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: TextButton(
                onPressed: () {
                  Link(article.url.toString());
                },
                child: Text(article.source!.name.toString())),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(article.publishedAt!),
          ),
        ],
      ),
    );
  }
}
