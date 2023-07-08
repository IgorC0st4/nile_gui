import 'dart:convert';
import 'dart:io';
import 'package:nile_gui/src/models/game_config_model.dart';
import 'package:path/path.dart' as path;

import 'package:path_provider/path_provider.dart';

class GameConfigDao {
  late Directory _supportDirectory;
  GameConfigDao._();
  static Future<GameConfigDao> create() async {
    var instance = GameConfigDao._();
    instance._supportDirectory = await getApplicationSupportDirectory();
    return instance;
  }

  Future<void> setGameConfig(String id, GameConfigModel gameConfig) async {
    Directory gamesConfigsDirectory =
        Directory(path.join(_supportDirectory.path, 'games_configs'));
    if (!gamesConfigsDirectory.existsSync()) {
      gamesConfigsDirectory.createSync(recursive: true);
    }
    File gameConfigFile =
        File(path.join(_supportDirectory.path, 'games_configs', '$id.json'));
    await gameConfigFile.writeAsString(jsonEncode(gameConfig.toMap()));
  }

  Future<GameConfigModel> getGameConfig(String id) async {
    File gameConfigFile =
        File(path.join(_supportDirectory.path, 'games_configs', '$id.json'));
    final rawData = jsonDecode(gameConfigFile.readAsStringSync());
    return GameConfigModel.fromJSON(rawData);
  }

  Future<void> deleteGameConfig(String id) async {
    File gameConfigFile =
        File(path.join(_supportDirectory.path, 'games_configs', '$id.json'));
    await gameConfigFile.delete();
  }

  Future<List<GameConfigModel>> getAllConfigs() async {
    Directory gamesConfigsDirectory =
        Directory(path.join(_supportDirectory.path, 'games_configs'));
    if (!gamesConfigsDirectory.existsSync()) {
      gamesConfigsDirectory.createSync(recursive: true);
    }
    List<FileSystemEntity> references = gamesConfigsDirectory.listSync();
    List<GameConfigModel> gamesConfigs = [];
    references.forEach((reference) {
      File configFile = File(reference.path);
      var rawData = jsonDecode(configFile.readAsStringSync());
      gamesConfigs.add(GameConfigModel.fromJSON(rawData));
    });

    return gamesConfigs;
  }
}
