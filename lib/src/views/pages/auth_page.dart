import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nile_gui/src/controllers/app_config_controller.dart';
import 'package:nile_gui/src/controllers/global_state_controller.dart';
import 'package:nile_gui/src/controllers/nile_controller.dart';
import 'package:nile_gui/src/views/components/info_dialog.dart';
import 'package:process_run/shell.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() {
    return AuthPageState();
  }
}

class AuthPageState extends State<AuthPage> {
  String _redirectedUrl = '';
  final List<String> _processStdout = [];
  late Process _authenticationProcess;
  late NileController nileController;

  @override
  void initState() {
    super.initState();
    initNileController();
  }

  void initNileController() async {
    nileController = await NileController.create();
  }

  void startAuthentication() async {
    try {
      _authenticationProcess =
          await nileController.startAuthenticationProcess();

      _authenticationProcess.stdout.transform(utf8.decoder).listen((event) {
        setState(() {
          _processStdout.add(event);
        });
      });
      _authenticationProcess.stdin.writeln();
    } on ShellException catch (expection) {
      showDialog(
          context: context,
          builder: (context) {
            return InfoDialog(
                title: 'A shell exception ocurred:',
                message: expection.message);
          });
    } catch (expection) {
      showDialog(
          context: context,
          builder: (context) {
            return InfoDialog(
                title: 'An unexpected error ocurred:',
                message:
                    '${expection.runtimeType.toString()}\n\n${expection.toString()}');
          });
    }
  }

  void validateAuthentication() async {
    try {
      nileController.finishAuthenticationProcess(
          _authenticationProcess, _redirectedUrl);
      GlobalStateController.instance.appConfig.initalSetupDone = true;
      AppConfigController appConfigController =
          await AppConfigController.create();
      appConfigController
          .setAppConfig(GlobalStateController.instance.appConfig);
      Navigator.of(context).pushReplacementNamed('/library');
    } on ShellException catch (expection) {
      showDialog(
          context: context,
          builder: (context) {
            return InfoDialog(
                title: 'A shell exception ocurred:',
                message: expection.message);
          });
    } catch (expection) {
      showDialog(
          context: context,
          builder: (context) {
            return InfoDialog(
                title: 'An unexpected error ocurred:',
                message:
                    '${expection.runtimeType.toString()}\n\n${expection.toString()}');
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Authentication'),
        ),
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 2 > 500
                    ? MediaQuery.of(context).size.width / 2
                    : 500,
                height: 600,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Log into your account',
                            style: TextStyle(fontSize: 30),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Click on the below button to start the authentication process. A new browser window should appear. If it doesn\'t load, copy and paste the generated URL in your browser. After the login process, copy and the paste the URL you\'re redirect to on the field below and click on the validate button.',
                            style: TextStyle(fontSize: 15),
                            textAlign: TextAlign.justify,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 40,
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: () {
                                  startAuthentication();
                                },
                                child:
                                    const Text('Start authentication process')),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Divider(),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 200,
                            child: ListView.builder(
                                itemCount: _processStdout.length,
                                itemBuilder: (context, index) => ListTile(
                                    title: Container(
                                        margin: const EdgeInsets.all(5),
                                        child: SelectableText(
                                          _processStdout[index],
                                        )))),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Divider(),
                          const SizedBox(
                            height: 10,
                          ),
                          TextField(
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText:
                                    'Paste amazon url you got redirected to:'),
                            onChanged: (text) {
                              _redirectedUrl = text;
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 40,
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: () {
                                  validateAuthentication();
                                },
                                child: const Text('Validate')),
                          )
                        ]),
                  ),
                ),
              ),
            )));
  }
}
