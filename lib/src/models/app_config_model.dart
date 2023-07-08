class AppConfigModel {
  String defaultRunner;
  String defaultBottleName;
  String defaultWinePrefixPath;
  String defaultWineBinaryPath;
  String defaultBasePath;
  bool enableDarkTheme;
  bool initalSetupDone;

  AppConfigModel(
      this.defaultRunner,
      this.defaultBottleName,
      this.defaultWinePrefixPath,
      this.defaultWineBinaryPath,
      this.defaultBasePath,
      this.enableDarkTheme,
      this.initalSetupDone);

  AppConfigModel.fromJSON(Map<String, dynamic> json)
      : defaultRunner = json['defaultRunner'],
        defaultBottleName = json['defaultBottleName'],
        defaultWinePrefixPath = json['defaultWinePrefixPath'],
        defaultWineBinaryPath = json['defaultWineBinaryPath'],
        defaultBasePath = json['defaultBasePath'],
        enableDarkTheme = json['enableDarkTheme'],
        initalSetupDone = json['initalSetupDone'];
  AppConfigModel.defaultConfig()
      : defaultRunner = 'Bottles',
        defaultBottleName = 'Nile',
        defaultWinePrefixPath = '',
        defaultWineBinaryPath = '',
        defaultBasePath = '',
        enableDarkTheme = true,
        initalSetupDone = false;

  Map<String, dynamic> toMap() {
    return {
      'defaultRunner': defaultRunner,
      'defaultBottleName': defaultBottleName,
      'defaultWinePrefixPath': defaultWinePrefixPath,
      'defaultWineBinaryPath': defaultWineBinaryPath,
      'defaultBasePath': defaultBasePath,
      'enableDarkTheme': enableDarkTheme,
      'initalSetupDone': initalSetupDone
    };
  }
}
