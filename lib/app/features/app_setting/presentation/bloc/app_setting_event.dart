part of 'app_setting_bloc.dart';

@immutable
abstract class AppSettingEvent {}

class ChangeLanguage extends AppSettingEvent {
  final String language;

  ChangeLanguage({required this.language});
}
