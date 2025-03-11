import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_perro_helper/models/abstracts/database_paths.dart';
import 'package:doctor_perro_helper/models/consumers/dolar_price_text.dart';
import 'package:doctor_perro_helper/models/dolar_price_in_bs.dart';
import 'package:doctor_perro_helper/utils/database/document_helper.dart';
import 'package:doctor_perro_helper/utils/toast_message_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChangeDolarPrice extends StatelessWidget {
  const ChangeDolarPrice({super.key});

  @override
  Widget build(BuildContext context) {
    return const AlertDialog(
      title: Text("Cambiar Valor:"),
      content: ChangePriceTextField(),
    );
  }
}

class ChangePriceTextField extends ConsumerStatefulWidget {
  const ChangePriceTextField({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ChangePriceTextFieldState();
}

class _ChangePriceTextFieldState extends ConsumerState<ChangePriceTextField> {
  String fieldValue = "0";
  bool isInvalid = true;

  set textFieldValue(String currentTextFieldValue) {
    isInvalid = !RegExp(r"^[0-9]+(\.[0-9]+)?$").hasMatch(currentTextFieldValue);
    fieldValue = currentTextFieldValue;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return TextField(
      autofocus: true,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        suffix: CurrentDolarPriceText(
          text: (String latestValue) => "${latestValue}bs",
          style: TextStyle(
            fontSize: theme.textTheme.labelLarge?.fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        errorText: isInvalid ? "Monto inválido" : null,
      ),
      onSubmitted: (String value) {
        if (isInvalid) {
          Navigator.pop(context);
          return;
        }

        double parsed = double.tryParse(value) ?? 0.0;

        changeDolar(parsed).onError((e, st) {
          ToastMessage.error(
            title: Text("$e"),
            duration: const Duration(seconds: 5),
          );
        });

        Navigator.pop(context);
      },
      onChanged: (String value) => setState(
          () => isInvalid = !RegExp(r"^[0-9]+(\.[0-9]+)?$").hasMatch(value)),
    );
  }
}

Future<void> changeDolar(double amount) async {
  DocumentReference docRef = getDocument(
      CollectionsPaths.globalSettings, GlobalSettingsPaths.dolarPriceInBs);

  DocumentSnapshot docSnap = await docRef.get();
  Object? data = docSnap.data();

  DolarPriceInBsDoc dolarPriceInBsDoc =
      DolarPriceInBsDoc.fromJson(data as Map<String, dynamic>);

  DolarPriceInBsDoc? dolarPriceDoc =
      DolarPriceInBsDoc(history: dolarPriceInBsDoc.history);

  dolarPriceDoc.history
      .add(DolarPriceInBs(value: amount, updateTime: DateTime.now()));

  await docRef.update(dolarPriceDoc.toJson());
}
