import 'package:shared_preferences/shared_preferences.dart';

class AppSetting {
  static SharedPreferences? _localStorage;
  Future<SharedPreferences?> get localStorage async {
    _localStorage = await SharedPreferences.getInstance();
  }

  Future<String> getAppLanguage() async {
    return _localStorage!.getString("applicationLanguage") ?? 'en';
  }

  Future<void> ChangeAppLanguage(String language) async {
    _localStorage = await SharedPreferences.getInstance();
    _localStorage!.setString("applicationLanguage", language);
    language = await getAppLanguage();
    print(language);
  }
}
