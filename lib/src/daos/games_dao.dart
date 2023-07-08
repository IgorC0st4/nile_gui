import 'dart:convert';
import 'dart:io';
import 'package:nile_gui/src/controllers/game_config_controller.dart';
import 'package:nile_gui/src/models/game_config_model.dart';
import 'package:path/path.dart' as path;

import 'package:nile_gui/src/models/game_model.dart';
import 'package:path_provider/path_provider.dart';

class GamesDao {
  final String _libraryFileName = 'library.json';
  late Directory _supportDirectory;
  GamesDao._();
  static Future<GamesDao> create() async {
    var instance = GamesDao._();
    instance._supportDirectory = await getApplicationSupportDirectory();
    return instance;
  }

  Future<List<GameModel>> getLibrary() async {
    File libraryFile =
        File(path.join(_supportDirectory.path, _libraryFileName));
    final rawData = jsonDecode(libraryFile.readAsStringSync());
    List<GameModel> games = [];
    rawData.forEach((element) => games.add(GameModel.fromJSON(element)));
    return games;
  }

  /* Future<List<GameModel>> getOnlyInstalledGames() async {
    List<GameModel> allGames = await getLibrary();
    GameConfigController gameConfigController =
        await GameConfigController.create();
    List<GameConfigModel> allConfigs =
        await gameConfigController.getAllConfigs();

    List<GameModel> installedGames = [];
    installedGames = allGames.where((game) => allConfigs.firstWhere((config) => false))
  } */
}
