import 'package:flutter/material.dart';
import 'package:nile_gui/src/controllers/global_state_controller.dart';
import 'package:nile_gui/src/views/pages/auth_page.dart';
import 'package:nile_gui/src/views/pages/game_details_page.dart';
import 'package:nile_gui/src/views/pages/library_page.dart';
import 'package:nile_gui/src/views/pages/settings_page.dart';
import 'package:nile_gui/src/views/pages/welcome_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: GlobalStateController.instance,
      builder: (context, child) {
        return MaterialApp(
          theme: ThemeData(
              brightness:
                  GlobalStateController.instance.appConfig.enableDarkTheme
                      ? Brightness.dark
                      : Brightness.light),
          initialRoute: GlobalStateController.instance.appConfig.initalSetupDone
              ? '/library'
              : '/welcome',
          routes: {
            '/welcome': (context) => const WelcomePage(),
            '/auth': (context) => const AuthPage(),
            '/library': (context) => const LibraryPage(),
            '/game': (context) => const GameDetailsPage(),
            '/settings': (context) => const SettingsPage()
          },
        );
      },
    );
  }
}
