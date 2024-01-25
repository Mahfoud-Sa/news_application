import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/app/core/resources/app_database.dart';
import 'package:news_app/app/core/widgets/toast_message.dart';
import 'package:news_app/app/features/display_news/data/modules/article.dart';
import 'package:news_app/app/features/display_news/presentation/bloc/article_bloc.dart';
import 'package:news_app/app/features/display_news/presentation/bloc/article_event.dart';
import 'package:news_app/app/features/display_news/presentation/bloc/article_state.dart';
import 'package:news_app/app/features/display_news/presentation/widgets/news_card_widget_.dart';
import 'package:news_app/initialization_dependencies.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
        body: BlocConsumer<ArticleBloc, ArticleState>(
          buildWhen: (previous, current) {
            return current is! DropArticleState;
          },
          listener: (context, state) {
            if (state is DropArticleState) {
              if (state.status) {
                ToastMessage().SusseccMessage(
                  AppLocalizations.of(context)!
                      .article_has_been_deleted_susseflly,
                );
              } else {
                ToastMessage()
                    .Infoessage(AppLocalizations.of(context)!.failed_to_delete);
              }
            }
          },
          builder: (context, state) {
            if (state is ArticlesDone) {
              //empty result
              if (state.data.isEmpty) {
                return Center(
                    child: Text(AppLocalizations.of(context)!.nothingToShow));
              }
              //result
              else {
                return ListView.separated(
                  shrinkWrap: true,
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
                  SizedBox(
                      width: 160,
                      child: Text(
                          AppLocalizations.of(context)!.fetching_data_failed)),
                ],
              ));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}
