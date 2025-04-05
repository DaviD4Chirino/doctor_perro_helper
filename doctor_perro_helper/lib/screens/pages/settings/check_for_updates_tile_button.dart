import 'package:doctor_perro_helper/utils/check_for_updates.dart';
import 'package:doctor_perro_helper/utils/toast_message_helper.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class CheckForUpdatesTileButton extends StatefulWidget {
  const CheckForUpdatesTileButton({
    super.key,
  });

  @override
  State<CheckForUpdatesTileButton> createState() =>
      _CheckForUpdatesTileButtonState();
}

class _CheckForUpdatesTileButtonState extends State<CheckForUpdatesTileButton> {
  bool checking = false;

  String currentVersion = "0.0.0";

  Future<void> getValues() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      currentVersion = packageInfo.version;
    });
  }

  Future<void> manualCheckForUpdates() async {
    try {
      setState(() {
        checking = true;
      });
      bool query = await checkForUpdates(context);

      if (!query) {
        ToastMessage.info(
          title: Text("No hay actualizaciones pendientes"),
        );
      }
      setState(() {
        checking = false;
      });
    } catch (e) {
      ToastMessage.error(
        title: Text("Error buscando actualizaciones"),
      );
      setState(() {
        checking = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getValues();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: manualCheckForUpdates,
      leading: const Icon(Icons.update_sharp),
      title: const Text("Revisar Actualizaciones"),
      subtitle: Text("Versión Actual: v$currentVersion"),
      trailing: checking ? CircularProgressIndicator() : null,
    );
  }
}
