import 'package:nile_gui/src/daos/game_config_dao.dart';
import 'package:nile_gui/src/models/game_config_model.dart';

class GameConfigController {
  late GameConfigDao gameConfigDao;

  GameConfigController._();

  static Future<GameConfigController> create() async {
    var instance = GameConfigController._();
    instance.gameConfigDao = await GameConfigDao.create();
    return instance;
  }

  Future<GameConfigModel> getGameConfig(String id) async {
    return gameConfigDao.getGameConfig(id);
  }

  Future<void> setGameConfig(String id, GameConfigModel gameConfig) async {
    await gameConfigDao.setGameConfig(id, gameConfig);
  }

  Future<void> deleteGameConfig(String id) async {
    await gameConfigDao.deleteGameConfig(id);
  }

  Future<List<GameConfigModel>> getAllConfigs() async {
    return gameConfigDao.getAllConfigs();
  }
}
