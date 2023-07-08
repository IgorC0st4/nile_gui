import 'package:flutter/material.dart';
import 'package:nile_gui/src/models/game_model.dart';
import 'package:nile_gui/src/views/components/game_list_item.dart';

class GamesList extends StatelessWidget {
  final List<GameModel> games;

  const GamesList({super.key, required this.games});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: games.length,
      itemBuilder: (context, index) {
        return GameListItem(game: games[index]);
      },
    );
  }
}
