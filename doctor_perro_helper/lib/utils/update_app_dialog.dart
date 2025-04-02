import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

AlertDialog updateAlertDialog(
  BuildContext context, {
  String downloadUrl = "",
  // we pass them because i dont want to call them twice
  String localVersion = "",
  String remoteVersion = "",
  String body = "",
}) {
  return AlertDialog(
    title: Text("Nueva Actualización Disponible ($remoteVersion)"),
    actions: [
      TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text("Cancelar"),
      ),
      FilledButton(
        onPressed: () {
          if (kDebugMode) {
            print(downloadUrl);
          }
        },
        child: Text("Descargar"),
      ),
    ],
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Change Log",
          style: TextStyle(fontSize: 32.0),
        ),
        Text(body),
      ],
    ),
  );
}
