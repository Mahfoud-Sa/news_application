import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/app/features/display_news/data/modules/article.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NewsDetailes extends StatelessWidget {
  final ArticleModel article;
  const NewsDetailes({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article.source!.name.toString()),
        centerTitle: true,
      ),
      body: ListView(
        //mainAxisAlignment: MainAxisAlignment.start,
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(
            imageUrl: article.urlToImage!,
            fit: BoxFit.fill,
            height: 300,
            width: double.infinity,
            placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) =>
                Image.asset('assets/images/error_imag.jpg'),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  article.title.toString(),
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  article.content.toString(),
                  style: const TextStyle(fontSize: 14),
                ),
                Text(
                  "${AppLocalizations.of(context)!.author}: ${article.author}",
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold),
                ),
                TextButton(
                    onPressed: () async {
                      if (!await launchUrl(Uri.parse(article.url.toString()))) {
                        throw Exception('Could not launch');
                      }
                    },
                    child: Text(
                      "{article.publishedAt!.year}/{article.publishedAt!.month}/{article.publishedAt!.hour}  ${AppLocalizations.of(context)!.clickForMoreDetailes} article.source!.name} >>",
                      style: const TextStyle(
                          fontSize: 12, color: Color.fromARGB(157, 90, 87, 62)),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
