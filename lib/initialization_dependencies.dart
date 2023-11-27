import 'package:shared_preferences/shared_preferences.dart';

String applicationLanguage = 'en';

Future<void> initializationDependencies() async {
//Local Storage
  SharedPreferences localStorage = await SharedPreferences.getInstance();
  applicationLanguage = localStorage.getString("applicationLanguage") ?? 'en';
}
