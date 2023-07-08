import 'package:flutter/material.dart';
import 'package:nile_gui/src/controllers/nile_controller.dart';
import 'package:nile_gui/src/exceptions/command_not_foud_exception.dart';
import 'package:nile_gui/src/utils/url_util.dart';
import 'package:nile_gui/src/views/components/info_dialog.dart';
import 'package:process_run/shell.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() {
    return WelcomePageState();
  }
}

class WelcomePageState extends State<WelcomePage> {
  bool _installDependencies = false;
  bool _downloadingNile = false;
  void downloadNile() async {
    try {
      setState(() {
        _downloadingNile = true;
      });
      NileController nileController = await NileController.create();
      await nileController.downloadNile(_installDependencies);
      Navigator.of(context).pushReplacementNamed('/auth');
    } on CommandNotFoundException catch (exception) {
      showDialog(
          context: context,
          builder: (context) {
            return InfoDialog(
                title: 'A required command was not found:',
                message: exception.getMessage());
          });
    } on ShellException catch (exception) {
      showDialog(
          context: context,
          builder: (context) {
            return InfoDialog(
                title: 'A shell exception ocurred:',
                message: exception.message);
          });
    } catch (exception) {
      showDialog(
          context: context,
          builder: (context) {
            return InfoDialog(
                title: 'An unexpected error ocurred:',
                message:
                    '${exception.runtimeType.toString()}\n\n${exception.toString()}');
          });
    } finally {
      setState(() {
        _downloadingNile = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Stack(
            children: [
              SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width * 2 / 3,
                  child: Image.asset(
                    'assets/images/welcome_background.jpg',
                    fit: BoxFit.cover,
                  )),
              Container(
                width: MediaQuery.of(context).size.width * 2 / 3,
                color: Colors.black.withOpacity(0.7),
              )
            ],
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: SizedBox(
            width: MediaQuery.of(context).size.width / 3,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Welcome!',
                        style: TextStyle(fontSize: 30),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'This tool is a graphical wrapper for the Nile CLI.',
                        style: TextStyle(fontSize: 15),
                      ),
                      InkWell(
                        child: const Text(
                          'Click here to see their github repository',
                          style: TextStyle(color: Colors.blue, fontSize: 15),
                        ),
                        onTap: () => UrlUtils().openUrlInExternalBrowser(
                            'https://github.com/imLinguin/nile'),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Before downloading the nile tool, please make sure to install the required dependencies listed on the repository. If you\'d like to let Nile_GUI try to install the dependencies, please check the box below (requires pip3).',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Checkbox(
                              value: _installDependencies,
                              onChanged: (value) {
                                setState(() {
                                  _installDependencies = !_installDependencies;
                                });
                              }),
                          const Text(
                              'Let Nile_GUI try to install dependencies (requires pip3)')
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'By clicking the button below, their tool will be downloaded and after its completion the authentication process will start.',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 40,
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: _downloadingNile
                                ? null
                                : () {
                                    downloadNile();
                                  },
                            child: const Text('Download Nile')),
                      )
                    ]),
              ),
            ),
          ),
        )
      ]),
    );
  }
}
