import 'package:doctor_perro_helper/models/providers/global_settings.dart';
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
    return TextField(
      autofocus: true,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        suffixText:
            "${ref.watch(globalSettingsNotifierProvider).dolarPrice?.latestValue}bs",
        errorText: isInvalid ? "Monto inválido" : null,
      ),
      onSubmitted: (String value) {
        if (isInvalid) {
          Navigator.pop(context);
          return;
        }

        double parsed = double.tryParse(value) ?? 0.0;
        ref
            .read(globalSettingsNotifierProvider.notifier)
            .changeDolarPriceInBs(parsed);
        Navigator.pop(context);
      },
      onChanged: (String value) => setState(
          () => isInvalid = !RegExp(r"^[0-9]+(\.[0-9]+)?$").hasMatch(value)),
    );
  }
}
