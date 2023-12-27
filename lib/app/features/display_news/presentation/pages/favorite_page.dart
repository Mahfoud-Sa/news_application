import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/app/core/resources/app_database.dart';
import 'package:news_app/app/features/display_news/data/modules/article.dart';
import 'package:news_app/app/features/display_news/presentation/bloc/article_bloc.dart';
import 'package:news_app/app/features/display_news/presentation/bloc/article_event.dart';
import 'package:news_app/app/features/display_news/presentation/bloc/article_state.dart';
import 'package:news_app/app/features/display_news/presentation/widgets/news_card_widget_.dart';
import 'package:news_app/initialization_dependencies.dart';

class FavoritePage extends StatefulWidget {
  FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  final List<ArticleModel> articles = [];
  void initState() {
    BlocProvider.of<ArticleBloc>(context).add(const GetSavedArticles());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<ArticleBloc, ArticleState>(
        builder: (_, state) {
          if (state is ArticlesDone) {
            //empty result
            if (state.data.isEmpty) {
              return const Text('Nothing to show');
            }
            //result
            else {
              return ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.data.length,
                separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                ),
                itemBuilder: (context, index) {
                  return NewsCardWidget(
                    article: state.data[index],
                    articleEvent: DropArticle(state.data[index].id),
                  );
                },
              );
            }
          } //Exception State
          else if (state is ArticlesException) {
            return Center(
                child: Column(
              children: [
                IconButton(
                    onPressed: () {
                      BlocProvider.of<ArticleBloc>(context)
                          .add(const GetSavedArticles());
                    },
                    icon: const Icon(Icons.refresh)),
                const SizedBox(width: 160, child: Text('fetching data failed')),
              ],
            ));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
        // body: FutureBuilder(
        //   future: getArticles(),
        //   builder: (context, snapshot) {
        //     if (snapshot.connectionState == ConnectionState.done) {
        //       return ListView.builder(
        //         itemCount: snapshot.data!.length,
        //         itemBuilder: (context, index) {
        //           return FavoriteNewsCardWidget(article: snapshot.data![index]);
        //         },
        //       );
        //     } else {
        //       return const CircularProgressIndicator();
        //     }
        //   },
      ),
    );
  }
}
