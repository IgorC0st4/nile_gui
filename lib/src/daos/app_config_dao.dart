import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as path;

import 'package:nile_gui/src/models/app_config_model.dart';
import 'package:path_provider/path_provider.dart';

class AppConfigDao {
  final String _configFileName = 'app_config.json';
  late Directory _supportDirectory;

  AppConfigDao._();
  static Future<AppConfigDao> create() async {
    var instance = AppConfigDao._();
    instance._supportDirectory = await getApplicationSupportDirectory();
    return instance;
  }

  File _fetchConfigFile() {
    return File(path.join(_supportDirectory.path, _configFileName));
  }

  AppConfigModel getAppConfig() {
    try {
      final rawData = jsonDecode(_fetchConfigFile().readAsStringSync());
      return AppConfigModel.fromJSON(rawData);
    } catch (e) {
      print('ERROR IN app_config_dao: ${e.toString()}');
      return AppConfigModel.defaultConfig();
    }
  }

  void setAppConfig(AppConfigModel appConfig) {
    _fetchConfigFile().writeAsStringSync(jsonEncode(appConfig.toMap()));
  }
}
