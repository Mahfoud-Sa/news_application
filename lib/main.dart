import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/app/features/app_setting/data/datasources/local_storage_services.dart';
import 'package:news_app/app/features/app_setting/presentation/bloc/app_setting_bloc.dart';
import 'package:news_app/app/features/app_setting/presentation/bloc/app_setting_bloc.dart';
import 'package:news_app/app/features/display_news/presentation/bloc/article_bloc.dart';
import 'package:news_app/app/features/display_news/presentation/pages/homePage.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:news_app/initialization_dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializationDependencies();
  runApp(MyApp(appLanguage: applicationLanguage));
}

class MyApp extends StatelessWidget {
  final String appLanguage;

  MyApp({super.key, required this.appLanguage});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<ArticleBloc>(
            create: (context) => ArticleBloc(),
          ),
          BlocProvider<AppSettingBloc>(
            create: (context) =>
                AppSettingBloc(appLanguage: applicationLanguage),
          ),
        ],
        child: BlocBuilder<AppSettingBloc, AppSettingState>(
          builder: (context, state) {
            return MaterialApp(
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              debugShowCheckedModeBanner: false,
              title: 'News Application',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
              ),
              locale: Locale(state.language),
              home: HomePage(
                Language: state.language,
              ),
            );
          },
        ));
  }
}
