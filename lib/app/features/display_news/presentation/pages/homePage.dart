import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/app/features/display_news/data/modules/article.dart';
import 'package:news_app/app/features/display_news/data/repository/article_repository_impl.dart';
import 'package:news_app/app/features/display_news/presentation/bloc/article_bloc.dart';
import 'package:news_app/app/features/display_news/presentation/bloc/article_event.dart';
import 'package:news_app/app/features/display_news/presentation/bloc/article_state.dart';
import 'package:news_app/app/features/display_news/presentation/pages/news_page_detailes.dart';
import 'package:news_app/app/features/display_news/presentation/widgets/search_widget.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final dio = Dio();

  Future<List<dynamic>> getNews() async {
    //ArticleRepositoryRepositoryImpl().getNewsArticles();
    final resp = ArticleRepositoryRepositoryImpl().getNewsArticles();
    print(resp);
    final response = await dio.get(
        'https://newsapi.org/v2/everything?q=bitcoin&apiKey=9b4791ffa29b4365a7db0cc3b0a97843');

    print(response.data['articles']);
    ArticleModel article = ArticleModel.fromJson(response.data['articles'][0]);
    var articles = response.data['articles']
        .map((json) => ArticleModel.fromJson(json))
        .toList();

    // print(article.t);
    return articles;
  }

  @override
  void initState() {
    BlocProvider.of<RemoteArticleBloc>(context).add(GetArticles());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        // BlocProvider.of<RemoteArticleBloc>(context).add();
      }),
      appBar: AppBar(
        title: Text('News Application'),
        centerTitle: true,
      ),
      drawer: Drawer(),
      body: ListView(
        children: [
          SearchWidget(),
          SizedBox(
            height: 40,
          ),
          _categorySection(),
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, bottom: 10),
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
            //print(state);
            // if (state is RemoteArticlesDone) {
            //   return ListView.separated(
            //     shrinkWrap: true,
            //     physics: NeverScrollableScrollPhysics(),
            //     itemCount: state.articles!.length,
            //     separatorBuilder: (context, index) => SizedBox(
            //       height: 10,
            //     ),
            //     itemBuilder: (context, index) {
            //       return NewsCardWidget(
            //         newsTitle: 'state.data![index].title',
            //         newsCategory: ' snapshot.data![index].source.id.toString()',
            //         imagePath: 'snapshot.data![index].urlToImage!',
            //       );
            //     },
            //   );
            // }
            if (state is RemoteArticlesLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is RemoteArticlesException) {
              return Center(child: Text(state.errorMessage));
            }
            if (state is RemoteArticlesDone) {
              return Center(child: Text(state.counter.toString()));
            }

            return Text('check internet connection');
          })
          // FutureBuilder(
          //   future: getNews(),
          //   builder: (context, snapshot) {
          //     if (snapshot.hasData) {
          //       return ListView.separated(
          //         shrinkWrap: true,
          //         physics: NeverScrollableScrollPhysics(),
          //         itemCount: snapshot.data!.length,
          //         separatorBuilder: (context, index) => SizedBox(
          //           height: 10,
          //         ),
          //         itemBuilder: (context, index) {
          //           return NewsCardWidget(
          //             newsTitle: snapshot.data![index].title,
          //             newsCategory: snapshot.data![index].source.id.toString(),
          //             imagePath: snapshot.data![index].urlToImage!,
          //           );
          //         },
          //       );
          //     }
          //     return const Center(child: CircularProgressIndicator());
          //   },
          // )
        ],
      ),
    );
  }
}

class NewsCardWidget extends StatelessWidget {
  final String newsTitle;
  final String newsCategory;
  final String imagePath;

  NewsCardWidget({
    super.key,
    required this.newsTitle,
    required this.newsCategory,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.blueGrey,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: GestureDetector(
        onTap: () {
          Get.to(() => NewsDetailes());
        },
        child: Card(
          child: Row(
            children: [
              Image.network(
                (imagePath),
                fit: BoxFit.fill,
                height: 100,
                width: 120,
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
                      newsTitle,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                  Text(
                    newsCategory,
                    style: TextStyle(fontSize: 12),
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
        Padding(
          padding: const EdgeInsets.only(left: 15.0, bottom: 10),
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
            itemCount: 10,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(top: 10, bottom: 10),
            separatorBuilder: (context, index) => SizedBox(
              width: 10,
            ),
            itemBuilder: (context, index) {
              return categoryWidget();
            },
          ),
        ),
      ],
    );
  }
}

class categoryWidget extends StatelessWidget {
  const categoryWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Icon(
                Icons.newspaper,
                color: Colors.black,
              ),
            ),
          ),
          const Text(
            'Sport',
            style: TextStyle(
                fontSize: 16, color: Colors.black, fontWeight: FontWeight.w800),
          )
        ],
      ),
    );
  }
}
