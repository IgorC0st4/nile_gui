import 'package:flutter/material.dart';
import 'package:nile_gui/src/controllers/app_config_controller.dart';
import 'package:nile_gui/src/models/app_config_model.dart';

class GlobalStateController extends ChangeNotifier {
  static GlobalStateController instance = GlobalStateController();
  late AppConfigController appConfigController;
  AppConfigModel appConfig = AppConfigModel.defaultConfig();

  Future<void> initConfigController() async {
    appConfigController = await AppConfigController.create();
  }

  refreshAppConfig() {
    appConfig = appConfigController.getAppConfig();
    notifyListeners();
  }
}
