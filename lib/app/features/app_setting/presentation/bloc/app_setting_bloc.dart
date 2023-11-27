import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:news_app/app/core/resources/data_state.dart';
import 'package:news_app/app/features/app_setting/data/repository/app_setting_repository_imp.dart';

part 'app_setting_event.dart';
part 'app_setting_state.dart';

class AppSettingBloc extends Bloc<AppSettingEvent, AppSettingState> {
  AppSettingRepositoryImp repo = AppSettingRepositoryImp();
  String appLanguage;
  AppSettingBloc({required this.appLanguage})
      : super(AppSettingInitial(language: appLanguage)) {
    on<AppSettingEvent>((event, emit) async {
      if (event is AppSettingInitial) {
        var state = await repo.getAppLanguage();
        if (state is DataSuccess) {
          // appLanguage = state.data!;
          //emit(change)
        }
      } else if (event is ChangeLanguage) {
        if (appLanguage == 'en') {
          appLanguage = 'ar';
        } else {
          appLanguage = 'en';
        }
        repo.ChangeAppLanguage(appLanguage);
        emit(ChangeLanguageState(language: this.appLanguage));
      }
    });
  }
}
