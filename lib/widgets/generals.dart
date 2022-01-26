import 'package:flutter/material.dart';

void renderDialog(context, String content, IconData icon, Color color) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Icon(
              icon,
              color: color,
            ),
            content: Text(
              content,
              textAlign: TextAlign.center,
            ),
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop(1);
                  },
                  child: const Text("Aceptar"))
            ],
          ));
}

