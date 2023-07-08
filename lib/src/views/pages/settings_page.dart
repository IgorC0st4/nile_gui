import 'package:flutter/material.dart';
import 'package:nile_gui/src/controllers/app_config_controller.dart';
import 'package:nile_gui/src/controllers/global_state_controller.dart';
import 'package:nile_gui/src/models/app_config_model.dart';
import 'package:nile_gui/src/views/components/info_dialog.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() {
    return SettingsPageState();
  }
}

List<String> _runners = <String>['Bottles', 'Wine'];

class SettingsPageState extends State<SettingsPage> {
  final AppConfigModel _currentConfig =
      AppConfigModel.fromJSON(GlobalStateController.instance.appConfig.toMap());

  bool checkChanges() {
    final currentConfigMap = _currentConfig.toMap();
    final globalConfigMap = GlobalStateController.instance.appConfig.toMap();
    for (var key in globalConfigMap.keys) {
      if (currentConfigMap[key] != globalConfigMap[key]) return true;
    }
    return false;
  }

  bool validateChanges() {
    if (_currentConfig.defaultRunner == 'Bottles') {
      return _currentConfig.defaultBottleName.trim().isNotEmpty;
    } else {
      return _currentConfig.defaultWineBinaryPath.trim().isNotEmpty &&
          _currentConfig.defaultWinePrefixPath.trim().isNotEmpty;
    }
  }

  void saveAppSettings() async {
    try {
      if (checkChanges()) {
        if (validateChanges()) {
          AppConfigController appConfigController =
              await AppConfigController.create();
          appConfigController.setAppConfig(_currentConfig);
          GlobalStateController.instance.refreshAppConfig();
          showDialog(
              context: context,
              builder: (context) {
                return const InfoDialog(
                    title: 'Success',
                    message: 'The changes were saved successfully');
              });
        } else {
          showDialog(
              context: context,
              builder: (context) {
                return const InfoDialog(
                    title: 'Invalid changes:',
                    message:
                        'Please verify that all fields are correctly filled');
              });
        }
      }
    } catch (exception) {
      showDialog(
          context: context,
          builder: (context) {
            return InfoDialog(
                title: 'An unexpected error ocurred:',
                message:
                    '${exception.runtimeType.toString()}\n\n${exception.toString()}');
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Settings'),
        ),
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  margin: const EdgeInsets.all(10),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        const Center(
                          child: Text(
                            'These are the default settings that will be loaded in the installation process.',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        const Center(
                          child: Text(
                            'You\'ll still be able customize the settings for every game in the installation dialog.',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            const Text('Enable dark theme : '),
                            Switch(
                                value: _currentConfig.enableDarkTheme,
                                onChanged: (value) {
                                  setState(() {
                                    _currentConfig.enableDarkTheme =
                                        !_currentConfig.enableDarkTheme;
                                  });
                                })
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            const Text('Runner: '),
                            DropdownButton<String>(
                              value: _currentConfig.defaultRunner,
                              elevation: 10,
                              onChanged: (value) {
                                setState(() {
                                  _currentConfig.defaultRunner = value!;
                                });
                              },
                              items: _runners.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        _currentConfig.defaultRunner == 'Bottles'
                            ? Column(
                                children: [
                                  TextFormField(
                                    initialValue:
                                        _currentConfig.defaultBottleName,
                                    decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Bottle name'),
                                    onChanged: (text) {
                                      _currentConfig.defaultBottleName = text;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                      'Only flatpack version is supported.'),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              )
                            : Column(
                                children: [
                                  TextFormField(
                                    initialValue:
                                        _currentConfig.defaultWinePrefixPath,
                                    decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Wine prefix path'),
                                    onChanged: (text) {
                                      _currentConfig.defaultWinePrefixPath =
                                          text;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    initialValue:
                                        _currentConfig.defaultWineBinaryPath,
                                    decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Wine binary path'),
                                    onChanged: (text) {
                                      _currentConfig.defaultWineBinaryPath =
                                          text;
                                    },
                                  )
                                ],
                              ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          initialValue: _currentConfig.defaultBasePath,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText:
                                  'Leave blank to install game at \$HOME/Games/nile',
                              labelText: 'Base installation path'),
                          onChanged: (text) {
                            _currentConfig.defaultBasePath = text;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                            'Leave blank to install game at \$HOME/Games/nile.'),
                        const SizedBox(
                          height: 10,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            saveAppSettings();
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green),
                          child: const SizedBox(
                            width: double.infinity,
                            child: Text(
                              'Save',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )));
  }
}
