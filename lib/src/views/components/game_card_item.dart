import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nile_gui/src/models/game_model.dart';

class GameCardItem extends StatelessWidget {
  final GameModel game;

  const GameCardItem({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed('/game', arguments: {"game": game});
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Column(children: [
          SizedBox(
            width: 350,
            height: 250,
            child: CachedNetworkImage(
              placeholder: (context, url) => const CircularProgressIndicator(),
              imageUrl: game.iconUrl,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(game.title)
        ]),
      ),
    );
  }
}
