import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/app/features/display_news/data/modules/article.dart';
import 'package:news_app/app/features/display_news/presentation/bloc/article_bloc.dart';
import 'package:news_app/app/features/display_news/presentation/bloc/article_event.dart';
import 'package:news_app/app/features/display_news/presentation/bloc/article_state.dart';
import 'package:news_app/app/features/display_news/presentation/pages/news_page_detailes.dart';
import 'package:news_app/app/features/display_news/presentation/widgets/search_widget.dart';
import 'package:news_app/app/core/resources/category.dart' as category;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    BlocProvider.of<RemoteArticleBloc>(context).add(const GetAllArticles());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News Application'),
        centerTitle: true,
      ),
      drawer: const Drawer(),
      body: ListView(
        children: [
          const SearchWidget(),
          const SizedBox(
            height: 40,
          ),
          const _categorySection(),
          const SizedBox(
            height: 40,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 15.0, bottom: 10),
            child: Text(
              'Last News',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
          ),
          BlocBuilder<RemoteArticleBloc, RemoteArticleState>(
              builder: (_, state) {
            if (state is RemoteArticlesDone) {
              return ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.data!.length,
                separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                ),
                itemBuilder: (context, index) {
                  return NewsCardWidget(
                    article: state.data[index],
                  );
                },
              );
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
            children: [
              CachedNetworkImage(
                imageUrl: article.urlToImage!,
                fit: BoxFit.fill,
                height: 100,
                width: 120,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) =>
                    Image.asset('assets/images/error_imag.jpg'),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
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
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _categorySection extends StatelessWidget {
  const _categorySection({
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
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(top: 10, bottom: 10),
            children: [
              category.Category(
                name: 'Sport',
                icon: Icon(
                  Icons.newspaper,
                  color: Colors.black,
                ),
              ),
              category.Category(
                name: 'Technology',
                icon: const Icon(
                  Icons.integration_instructions,
                  color: Colors.black,
                ),
              ),
              category.Category(
                name: 'Money',
                icon: const Icon(
                  Icons.catching_pokemon,
                  color: Colors.black,
                ),
              ),
              category.Category(
                name: 'Country',
                icon: const Icon(
                  Icons.catching_pokemon,
                  color: Colors.black,
                ),
              ),
            ]
                .map((e) => categoryWidget(
                      name: e.name,
                      icon: e.icon,
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }
}

class categoryWidget extends StatelessWidget {
  final String name;
  final Icon icon;

  const categoryWidget({
    super.key,
    required this.name,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<RemoteArticleBloc>(context)
            .add(GetSearchArticles(name));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        height: 50,
        width: 120,
        decoration: BoxDecoration(
            color: Colors.amber, borderRadius: BorderRadius.circular(15)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(50)),
              child: Padding(padding: const EdgeInsets.all(12.0), child: icon),
            ),
            Text(
              name,
              style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w800),
            )
          ],
        ),
      ),
    );
  }
}
