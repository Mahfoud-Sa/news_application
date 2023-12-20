import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:news_app/app/core/resources/app_database.dart';
import 'package:news_app/app/features/display_news/data/modules/article.dart';
import 'package:news_app/app/features/display_news/presentation/pages/news_page_detailes.dart';
import 'package:news_app/app/features/favorite_news/presentation/widgets/favorite_btn.dart';
import 'package:news_app/initialization_dependencies.dart';

class FavoriteNewsCardWidget extends StatelessWidget {
  final ArticleModel article;

  const FavoriteNewsCardWidget({
    super.key,
    required this.article,
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
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                        alignment: Alignment.topRight,
                        child: DropBtn(
                          article_id: article.id!,
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

class DropBtn extends StatefulWidget {
  final int article_id;
  const DropBtn({super.key, required this.article_id});

  @override
  State<DropBtn> createState() => _DropBtnState();
}

class _DropBtnState extends State<DropBtn> {
  bool isFavorite = true;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.delete,
        color: isFavorite ? Colors.red : null,
      ),
      onPressed: () async {
        setState(() {
          isFavorite = !isFavorite;
        });

        var _AppDataBaseServices = await getIt.get<AppDataBaseServices>();
        print(await _AppDataBaseServices.articleDao
            .deletetArticle(widget.article_id));
      },
    );
  }
}
