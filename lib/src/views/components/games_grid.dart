import 'package:flutter/material.dart';
import 'package:nile_gui/src/models/game_model.dart';
import 'package:nile_gui/src/views/components/game_card_item.dart';

class GamesGrid extends StatelessWidget {
  final List<GameModel> games;

  const GamesGrid({super.key, required this.games});
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: games.length,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: MediaQuery.of(context).size.width /
                (MediaQuery.of(context).size.width / 350)),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return GameCardItem(game: games[index]);
        });
  }
}
