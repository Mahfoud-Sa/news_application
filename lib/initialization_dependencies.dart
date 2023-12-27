import 'package:get_it/get_it.dart';
import 'package:news_app/app/core/resources/app_database.dart';
import 'package:news_app/app/features/display_news/data/modules/article.dart';
import 'package:news_app/app/features/display_news/data/modules/source.dart';
import 'package:shared_preferences/shared_preferences.dart';

String applicationLanguage = 'en';

final getIt = GetIt.instance;
bool showOnBordingPages = true;
Future<void> initializationDependencies() async {
//Local Storage
  SharedPreferences localStorage = await SharedPreferences.getInstance();
  applicationLanguage = localStorage.getString("applicationLanguage") ?? 'en';

  // await AppDataBaseServices();
  final _appDataBaseServices = await AppDataBaseServices();
  await _appDataBaseServices.intialDb();
  getIt.registerSingleton<AppDataBaseServices>(_appDataBaseServices);

  var _AppDataBaseServices = await getIt.get<AppDataBaseServices>();
  await _AppDataBaseServices.articleDao.getAll();

  // print(await _AppDataBaseServices.articleDao.insertArticle(ArticleModel(
  //   source: const SourceModel(id: '2', name: 'sultain'),
  //   author: 'CNN',
  //   title: 'Samsung',
  //   content: 'Galaxy s23',
  //   descripution: 'one of the most related phones in this word',
  //   url: 'https://www.youtube.com/watch?v=eNvUS-6PTbs',
  //   urlToImage:
  //       'https://th.bing.com/th/id/OIP.7V4xLOup-MrOUTgvKLoNTgHaEH?rs=1&pid=ImgDetMain',
  //   publishedAt: DateTime.now(),
  //   //  content: article.content,
  // )));
}
