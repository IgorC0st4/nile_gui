import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:nile_gui/src/models/game_model.dart';
import 'package:nile_gui/src/views/components/game_details_card_content.dart';

class GameDetailsPage extends StatefulWidget {
  const GameDetailsPage({super.key});

  @override
  State<GameDetailsPage> createState() {
    return GameDetailsPageState();
  }
}

class GameDetailsPageState extends State<GameDetailsPage> {
  late GameModel _game;
  void getGame(BuildContext context) {
    final temp = ModalRoute.of(context)?.settings.arguments as dynamic;
    _game = temp['game'];
  }

  @override
  Widget build(BuildContext context) {
    getGame(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(_game.title),
      ),
      body: Stack(
        children: [
          SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: CachedNetworkImage(
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                imageUrl: _game.backgroundUrl,
                fit: BoxFit.cover,
              )),
          Container(
            color: Colors.black.withOpacity(0.8),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                    flex: 2,
                    child: ImageSlideshow(
                      isLoop: true,
                      autoPlayInterval: 10000,
                      indicatorRadius: 10,
                      height: MediaQuery.of(context).size.height / 2,
                      initialPage: 0,
                      indicatorColor: Colors.blueAccent,
                      indicatorBackgroundColor: Colors.grey,
                      children: _game.screenshots
                          .map((screenshot) => CachedNetworkImage(
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(),
                                imageUrl: screenshot,
                              ))
                          .toList(),
                    )),
                Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Card(
                          elevation: 2,
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GameDetailsCardContent(game: _game)),
                        )
                      ],
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
