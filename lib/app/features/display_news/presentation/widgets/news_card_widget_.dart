import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/app/features/display_news/data/modules/article.dart';
import 'package:news_app/app/features/display_news/presentation/bloc/article_event.dart';
import 'package:news_app/app/features/display_news/presentation/pages/news_page_detailes.dart';
import 'package:news_app/app/features/display_news/presentation/widgets/favorite_btn.dart';

class NewsCardWidget extends StatelessWidget {
  final ArticleModel article;
  final ArticleEvent articleEvent;
  const NewsCardWidget({
    super.key,
    required this.article,
    required this.articleEvent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return NewsDetailes(
                article: article,
              );
            },
          ));
        },
        child: Card(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CachedNetworkImage(
                imageUrl: article.urlToImage!,
                fit: BoxFit.fill,
                height: 100,
                width: 120,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) =>
                    Image.asset('assets/images/error_imag.jpg'),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                        alignment: Alignment.topRight,
                        child: FavoriteBtn(
                          articleEntity: article,
                          event: articleEvent,
                        )),
                    SizedBox(
                      width: 200,
                      child: Text(
                        article.title!,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    Text(
                      article.author!,
                      style: const TextStyle(
                        fontSize: 12,
                        overflow: TextOverflow.fade,
                      ),
                      maxLines: 2,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
