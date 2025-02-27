import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_perro_helper/models/abstracts/database_paths.dart';
import 'package:doctor_perro_helper/models/dolar_price_in_bs.dart';
import 'package:doctor_perro_helper/models/providers/global_settings.dart';
import 'package:doctor_perro_helper/models/providers/streams/dolar_price_stream.dart';
import 'package:doctor_perro_helper/utils/database/document_helper.dart';
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
    final AsyncValue<DolarPriceInBsDoc> dolarPriceStream =
        ref.watch(dolarPriceProvider);

    String suffixText = dolarPriceStream.when(
        data: (data) => "${data.latestValue}bs",
        error: (e, st) => "Error",
        loading: () => "...");

    return TextField(
      autofocus: true,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        suffixText: suffixText,
        errorText: isInvalid ? "Monto inválido" : null,
      ),
      onSubmitted: (String value) {
        if (isInvalid) {
          Navigator.pop(context);
          return;
        }

        double parsed = double.tryParse(value) ?? 0.0;
        changeDolar(parsed);
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
  var data = docSnap.data();

  DolarPriceInBsDoc dolarPriceInBsDoc =
      DolarPriceInBsDoc.fromJson(data as Map<String, dynamic>);

  DolarPriceInBsDoc? dolarPriceDoc =
      DolarPriceInBsDoc(history: dolarPriceInBsDoc.history);
  dolarPriceDoc.history
      .add(DolarPriceInBs(value: amount, updateTime: DateTime.now()));

  await docRef.update(dolarPriceDoc.toJson());
}
