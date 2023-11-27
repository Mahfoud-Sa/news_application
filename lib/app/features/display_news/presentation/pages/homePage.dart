import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_flutter/icons_flutter.dart';
import 'package:news_app/app/features/display_news/data/modules/article.dart';
import 'package:news_app/app/features/display_news/presentation/bloc/article_bloc.dart';
import 'package:news_app/app/features/display_news/presentation/bloc/article_event.dart';
import 'package:news_app/app/features/display_news/presentation/bloc/article_state.dart';
import 'package:news_app/app/features/display_news/presentation/pages/news_page_detailes.dart';
import 'package:news_app/app/features/display_news/presentation/widgets/my_drawer.dart';
import 'package:news_app/app/features/display_news/presentation/widgets/search_widget.dart';
import 'package:news_app/app/core/resources/category.dart' as category;
import 'package:word_generator/word_generator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String search = '';
  @override
  void initState() {
    final wordGenerator = WordGenerator();
    String noun = wordGenerator.randomNoun();
    search = noun;
    BlocProvider.of<RemoteArticleBloc>(context).add(GetSearchArticles(noun));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.newsApplication),
        centerTitle: true,
      ),
      drawer: const MyDrawer(),
      body: ListView(
        children: [
          SearchWidget(search: search),
          /* const SizedBox(
            height: 40,
          ),
           _categorySection(),*/
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, bottom: 10),
            child: Text(
              AppLocalizations.of(context)!.lastNews,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
          ),
          BlocBuilder<RemoteArticleBloc, RemoteArticleState>(
              builder: (_, state) {
            if (state is RemoteArticlesDone) {
              if (state.data.isEmpty) {
                return const Text('Nothing to show');
              } else {
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
                    );
                  },
                );
              }
            } else if (state is RemoteArticlesException) {
              return Center(
                  child: Column(
                children: [
                  IconButton(
                      onPressed: () {
                        BlocProvider.of<RemoteArticleBloc>(context)
                            .add(GetSearchArticles(search));
                      },
                      icon: const Icon(Icons.refresh)),
                  SizedBox(width: 160, child: Text('No internet connection')),
                ],
              ));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          })
        ],
      ),
    );
  }
}

class NewsCardWidget extends StatelessWidget {
  final ArticleModel article;

  const NewsCardWidget({
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

class _categorySection extends StatelessWidget {
  final items = [
    category.Category(
        name: 'All',
        icon: Icon(
          Icons.category,
          color: Colors.black,
        ),
        color: Color.fromARGB(255, 202, 29, 95)),
    category.Category(
      name: 'Sport',
      icon: Icon(
        FontAwesome.space_shuttle,
        color: Colors.black,
      ),
      color: const Color.fromARGB(255, 68, 255, 146),
    ),
    category.Category(
      name: 'Technology',
      icon: const Icon(
        FontAwesome.laptop,
        color: Colors.black,
      ),
      color: Colors.amber,
    ),
    category.Category(
      name: 'Health',
      icon: const Icon(
        FontAwesome.hospital_o,
        color: Colors.black,
      ),
      color: Colors.blueAccent,
    ),
    category.Category(
      name: 'Funds',
      icon: const Icon(
        FontAwesome.money,
        color: Colors.black,
      ),
      color: Colors.orange,
    ),
  ];
  _categorySection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 15.0, bottom: 10),
          child: Text(
            'Category',
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
        Container(
          height: 150,
          //color: Colors.green,
          child: ListView.separated(
            itemCount: 5,
            separatorBuilder: (context, index) => const SizedBox(
              width: 10,
            ),
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(10),
            itemBuilder: (context, index) {
              return categoryWidget(
                name: items[index].name,
                icon: items[index].icon,
                color: items[index].color,
              );
            },
          ),
        ),
      ],
    );
  }
}

class categoryWidget extends StatelessWidget {
  final String name;
  final Icon icon;
  final Color color;

  const categoryWidget({
    super.key,
    required this.name,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            fixedSize: const Size(125, 50),
            backgroundColor: color),
        onPressed: () {},
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CircleAvatar(
              radius: 30,
              child: icon,
            ),
            Text(
              name,
              style: const TextStyle(color: Colors.white),
            )
          ],
        ));
  }
}
