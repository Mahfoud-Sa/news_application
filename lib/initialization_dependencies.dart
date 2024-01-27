import 'package:get_it/get_it.dart';
import 'package:news_app/app/core/resources/app_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

String applicationLanguage = 'en';

final getIt = GetIt.instance;
bool showOnBordingPages = true;
Future<void> initializationDependencies() async {
//Local Storage
  SharedPreferences localStorage = await SharedPreferences.getInstance();
  applicationLanguage = localStorage.getString("applicationLanguage") ?? 'en';
  showOnBordingPages = localStorage.getBool('showOnBordingPages') ?? true;

  // await AppDataBaseServices();
  final _appDataBaseServices = await AppDataBaseServices();
  await _appDataBaseServices.intialDb();
  getIt.registerSingleton<AppDataBaseServices>(_appDataBaseServices);

  var _AppDataBaseServices = await getIt.get<AppDataBaseServices>();
  await _AppDataBaseServices.articleDao.getAll();
}
