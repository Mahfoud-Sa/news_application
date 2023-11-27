part of 'app_setting_bloc.dart';

@immutable
abstract class AppSettingState {
  final String language;

  AppSettingState({required this.language});
}

final class AppSettingInitial extends AppSettingState {
  AppSettingInitial({required super.language});
}

final class ChangeLanguageState extends AppSettingState {
  ChangeLanguageState({required super.language});
}
