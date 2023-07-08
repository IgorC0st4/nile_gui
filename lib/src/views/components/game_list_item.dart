import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nile_gui/src/models/game_model.dart';

class GameListItem extends StatelessWidget {
  final GameModel game;

  const GameListItem({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed('/game', arguments: {"game": game});
      },
      child: ListTile(
        leading: CachedNetworkImage(
          placeholder: (context, url) => const CircularProgressIndicator(),
          imageUrl: game.logoUrl,
        ),
        title: Text(game.title),
        subtitle: Text(
            "Release date: ${DateTime.parse(game.releaseDate).toLocal().toString().substring(0, 10)}"),
      ),
    );
  }
}
