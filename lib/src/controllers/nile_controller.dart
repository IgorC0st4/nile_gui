import 'dart:io';
import 'package:nile_gui/src/exceptions/command_not_foud_exception.dart';
import 'package:nile_gui/src/models/game_config_model.dart';
import 'package:nile_gui/src/models/game_model.dart';
import 'package:path/path.dart' as path;

import 'package:path_provider/path_provider.dart';
import 'package:process_run/shell.dart';

class NileController {
  late Directory _supportDirectory;

  NileController._();

  static Future<NileController> create() async {
    final instance = NileController._();
    await instance.initSupportDirectory();
    return instance;
  }

  Future<void> initSupportDirectory() async {
    _supportDirectory = await getApplicationSupportDirectory();
  }

  String _getNileAppDirectoryPath() {
    return path.join(_supportDirectory.path, 'nile');
  }

  String _getNileConfigDirectoryPath() {
    return path.join(userAppDataPath, 'nile');
  }

  String _getNileExecutablePath() {
    return path.join(_getNileAppDirectoryPath(), 'bin', 'nile');
  }

  bool _checkIsNileAlreadyDownloaded() {
    return Directory(_getNileAppDirectoryPath()).existsSync();
  }

  Future<void> downloadNile(bool installDependecies) async {
    if (_checkIsNileAlreadyDownloaded()) {
      print('Nile has already been downloaded, skipping...');
    } else {
      final String? gitCommand = whichSync('git');
      if (gitCommand == null || gitCommand.isEmpty) {
        throw CommandNotFoundException('git');
      }

      Shell shell = Shell();
      shell = shell.cd(_supportDirectory.path);

      await shell.run('git clone https://github.com/imLinguin/nile');
      if (installDependecies) {
        await _installDependenciesWithPip3();
      }
    }
  }

  Future<void> _installDependenciesWithPip3() async {
    final String? pip3Command = whichSync('pip3');
    if (pip3Command == null || pip3Command.isEmpty) {
      throw CommandNotFoundException('pip3');
    }

    Shell shell = Shell();
    shell = shell.cd(_getNileAppDirectoryPath());
    await shell.run('pip3 install -r requirements.txt');
  }

  Future<Process> startAuthenticationProcess() {
    return Process.start(_getNileExecutablePath(), ['auth', '--login']);
  }

  void finishAuthenticationProcess(Process process, String redirectedURL) {
    process.stdin.write(redirectedURL);
  }

  Future<void> syncLibrary() async {
    final Shell shell = Shell();
    await shell
        .runExecutableArguments(_getNileExecutablePath(), ['library', 'sync']);

    File libraryFile =
        File(path.join(_getNileConfigDirectoryPath(), 'library.json'));
    await libraryFile.copy(path.join(_supportDirectory.path, 'library.json'));
  }

  Future<Process> invokeInstallGameCommand(
      GameModel game, GameConfigModel gameConfig, String basePath) async {
    List<String> arguments = ['install', game.id];
    if (basePath.isNotEmpty) {
      arguments.add('--base-path');
      arguments.add(basePath);
    }
    return Process.start(_getNileExecutablePath(), arguments);
  }
}
