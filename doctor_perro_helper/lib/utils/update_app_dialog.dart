import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

AlertDialog updateAlertDialog(
  BuildContext context, {
  String downloadUrl = "",
  // we pass them because i dont want to call them twice
  String localVersion = "",
  String remoteVersion = "",
  String body = "",
}) {
  final Uri _url = Uri.parse(downloadUrl);

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
          openUrl(_url);
        },
        child: Text("Descargar"),
      ),
    ],
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(body),
      ],
    ),
  );
}

Future<void> openUrl(Uri url) async {
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}
