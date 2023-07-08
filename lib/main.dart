import 'package:flutter/material.dart';
import 'package:nile_gui/app_widget.dart';
import 'package:nile_gui/src/controllers/global_state_controller.dart';

void main() {
  initConfig();
  runApp(const AppWidget());
}

void initConfig() async {
  await GlobalStateController.instance.initConfigController();
  GlobalStateController.instance.refreshAppConfig();
}
