import 'package:nile_gui/src/daos/games_dao.dart';
import 'package:nile_gui/src/models/game_model.dart';

class GamesController {
  late GamesDao gamesDao;

  GamesController._();

  static Future<GamesController> create() async {
    var instance = GamesController._();
    instance.gamesDao = await GamesDao.create();
    return instance;
  }

  Future<List<GameModel>> getLibrary() async {
    List<GameModel> games = await gamesDao.getLibrary();
    games.sort((a, b) => a.title.compareTo(b.title));
    return games;
  }
}
