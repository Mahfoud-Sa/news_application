import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/app/features/display_news/data/modules/article.dart';
import 'package:news_app/app/features/display_news/presentation/bloc/article_bloc.dart';
import 'package:news_app/app/features/display_news/presentation/bloc/article_event.dart';

class FavoriteBtn extends StatefulWidget {
  final ArticleModel articleEntity;
  final ArticleEvent event;
  const FavoriteBtn(
      {super.key, required this.articleEntity, required this.event});

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
        BlocProvider.of<ArticleBloc>(context).add(widget.event);
      },
    );
  }
}
