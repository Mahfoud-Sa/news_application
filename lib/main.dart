import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:news_app/app/features/display_news/data/modules/article.dart';
import 'package:news_app/app/features/display_news/data/repository/article_repository_impl.dart';
import 'package:news_app/app/features/display_news/domain/repository/article_repository.dart';
import 'package:news_app/article_detailes.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'news Application'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  final dio = Dio();

  Future<List<dynamic>> getHttp() async {
    //ArticleRepositoryRepositoryImpl().getNewsArticles();
    final resp = ArticleRepositoryRepositoryImpl().getNewsArticles();
    print(resp.);
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: FutureBuilder(
        future: getHttp(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    //Navigator.push()
                    Get.to(ArticleDetailes(
                        article: snapshot.data![0] as ArticleModel));
                    //print();
                  },
                  title: Image.network(snapshot.data![index].urlToImage!),
                  subtitle: Text(snapshot.data![index].source.id.toString()),
                );
              },
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
