import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nile_gui/src/models/game_model.dart';
import 'package:nile_gui/src/utils/url_util.dart';

class GameDetailsCardContent extends StatelessWidget {
  final GameModel game;

  const GameDetailsCardContent({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        CachedNetworkImage(
          placeholder: (context, url) => const CircularProgressIndicator(),
          imageUrl: game.logoUrl,
        ),
        const SizedBox(
          height: 20,
        ),
        Text('Description: ${game.shortDescription}',
            textAlign: TextAlign.justify),
        const SizedBox(
          height: 20,
        ),
        Text('Developer: ${game.developer}', textAlign: TextAlign.justify),
        const SizedBox(
          height: 20,
        ),
        Text('Publisher: ${game.publisher}', textAlign: TextAlign.justify),
        const SizedBox(
          height: 20,
        ),
        Text(
            "Release date: ${DateTime.parse(game.releaseDate).toLocal().toString().substring(0, 10)}",
            textAlign: TextAlign.justify),
        const SizedBox(
          height: 20,
        ),
        Text("Gamemodes: ${game.gameModes.toString()}",
            textAlign: TextAlign.justify),
        const SizedBox(
          height: 20,
        ),
        Text("Genres: ${game.genres.toString()}", textAlign: TextAlign.justify),
        const SizedBox(
          height: 20,
        ),
        Text("Keywords: ${game.keywords.toString()}",
            textAlign: TextAlign.justify),
        const SizedBox(
          height: 20,
        ),
        GridView.builder(
            itemCount: game.videos.length,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                childAspectRatio: 3, maxCrossAxisExtent: 150),
            shrinkWrap: true,
            itemBuilder: (context, index) => Container(
                  margin: const EdgeInsets.all(5),
                  child: ElevatedButton(
                      onPressed: () {
                        UrlUtils().openUrlInExternalBrowser(game.videos[index]);
                      },
                      child: Text('Video ${index + 1}')),
                )),
      ],
    );
  }
}
