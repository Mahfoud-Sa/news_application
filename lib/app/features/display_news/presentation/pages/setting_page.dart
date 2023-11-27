import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/app/features/app_setting/presentation/bloc/app_setting_bloc.dart';
import 'package:news_app/app/features/display_news/presentation/bloc/article_bloc.dart';
import 'package:news_app/app/features/display_news/presentation/bloc/article_event.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});
  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool language = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Setting',
          style: TextStyle(fontSize: 22),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Row(
                  children: [
                    Icon(
                      Icons.language,
                      color: Colors.blue,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Language ',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Switch(
                    value: language,
                    onChanged: (value) async {
                      setState(() {
                        language = !language;
                      });
                      BlocProvider.of<AppSettingBloc>(context).add(
                          ChangeLanguage(language: language ? 'ar' : 'en'));

                      // SharedPreferences localStorage =
                      //     await SharedPreferences.getInstance();
                      // localStorage.setString("applicationLanguage", 'ar');
                    })
              ],
            ),
            Divider(
              height: 20,
              thickness: 1,
            )
          ],
        ),
      ),
    );
  }
}
