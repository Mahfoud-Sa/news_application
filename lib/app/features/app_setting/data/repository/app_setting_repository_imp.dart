import 'package:news_app/app/core/resources/data_state.dart';
import 'package:news_app/app/features/app_setting/data/datasources/local_storage_services.dart';
import 'package:news_app/app/features/app_setting/domain/repository/app_setting_repository.dart';

class AppSettingRepositoryImp extends AppSettingRepository {
  @override
  Future<DataState<String>> getAppLanguage() async {
    String _language = await AppSetting().getAppLanguage();
    return DataSuccess(_language);
  }

  @override
  Future<void> ChangeAppLanguage(String language) async {
    await AppSetting().ChangeAppLanguage(language);
  }
}
