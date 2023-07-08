import 'package:flutter/material.dart';

class InfoDialog extends StatelessWidget {
  final String message;
  final String title;

  const InfoDialog({super.key, required this.message, required this.title});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: SizedBox(
        width: 500,
        child: Text(message, textAlign: TextAlign.justify),
      ),
      actions: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Close'))
      ],
    );
  }
}
