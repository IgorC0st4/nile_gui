import 'package:flutter/material.dart';
import 'package:nile_gui/src/controllers/games_controller.dart';
import 'package:nile_gui/src/controllers/nile_controller.dart';
import 'package:nile_gui/src/models/game_model.dart';
import 'package:nile_gui/src/views/components/games_grid.dart';
import 'package:nile_gui/src/views/components/games_list.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() {
    return LibraryPageState();
  }
}

class LibraryPageState extends State<LibraryPage> {
  List<GameModel> _games = [];
  bool _showAsGrid = true;

  @override
  void initState() {
    super.initState();
    loadLibrary();
  }

  void loadLibrary() async {
    GamesController gamesController = await GamesController.create();
    NileController nileController = await NileController.create();
    await nileController.syncLibrary();
    var temp = await gamesController.getLibrary();
    setState(() {
      _games = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Library'),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  _showAsGrid = !_showAsGrid;
                });
              },
              icon: Icon(_showAsGrid ? Icons.grid_3x3 : Icons.list)),
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/settings');
            },
            icon: const Icon(Icons.settings),
          )
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: _showAsGrid
              ? GamesGrid(games: _games)
              : GamesList(games: _games)),
    );
  }
}
