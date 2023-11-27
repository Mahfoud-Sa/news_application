import 'package:news_app/app/core/resources/data_state.dart';

abstract class AppSettingRepository {
  //data Storage
  Future<DataState<String>> getAppLanguage();
  Future<void> ChangeAppLanguage(String language);
}
