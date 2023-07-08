class GameConfigModel {
  final String runner;
  final String bottleName;
  final String winePrefixPath;
  final String wineBinaryPath;
  final String installationPath;

  GameConfigModel(this.runner, this.bottleName, this.winePrefixPath,
      this.wineBinaryPath, this.installationPath);

  GameConfigModel.fromJSON(Map<String, dynamic> json)
      : runner = json['runner'],
        bottleName = json['bottleName'],
        winePrefixPath = json['winePrefixPath'],
        wineBinaryPath = json['wineBinaryPath'],
        installationPath = '';
  GameConfigModel.defaultConfig()
      : runner = 'Bottles',
        bottleName = 'Nile',
        winePrefixPath = '',
        wineBinaryPath = '',
        installationPath = '';
  Map<String, dynamic> toMap() {
    return {
      'runner': runner,
      'bottleName': bottleName,
      'winePrefixPath': winePrefixPath,
      'wineBinaryPath': wineBinaryPath,
      'installationPath': installationPath
    };
  }
}
