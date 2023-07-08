import 'package:nile_gui/src/daos/app_config_dao.dart';
import 'package:nile_gui/src/models/app_config_model.dart';

class AppConfigController {
  late AppConfigDao appConfigDao;

  AppConfigController._();

  static Future<AppConfigController> create() async {
    var instance = AppConfigController._();
    instance.appConfigDao = await AppConfigDao.create();
    return instance;
  }

  AppConfigModel getAppConfig() {
    return appConfigDao.getAppConfig();
  }

  void setAppConfig(AppConfigModel appConfig) {
    appConfigDao.setAppConfig(appConfig);
  }
}
