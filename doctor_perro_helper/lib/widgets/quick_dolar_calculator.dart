import 'package:doctor_perro_helper/models/dolar_price_in_bs.dart';
import 'package:doctor_perro_helper/models/providers/streams/dolar_price_stream.dart';
import 'package:doctor_perro_helper/utils/copy_clipboard.dart';
import 'package:doctor_perro_helper/utils/toast_message_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuickDolarCalculator extends ConsumerStatefulWidget {
  const QuickDolarCalculator({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _QuickDolarCalculatorState();
}

class _QuickDolarCalculatorState extends ConsumerState<QuickDolarCalculator> {
  String fieldValue = "0";
  bool isInvalid = true;

  double amount = 0.0;

  String get textFieldValue {
    return fieldValue;
  }

  set textFieldValue(String currentTextFieldValue) {
    isInvalid = !RegExp(r"^[0-9]+(\.[0-9]+)?$").hasMatch(currentTextFieldValue);
    fieldValue = currentTextFieldValue;
    amount = currentTextFieldValue.isEmpty || isInvalid
        ? 0.0
        : double.parse(fieldValue);
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<DolarPriceInBsDoc> dolarPriceStream =
        ref.watch(dolarPriceProvider);
    double calculatedAmount = dolarPriceStream.maybeWhen(
      data: (data) => amount * data.latestValue,
      orElse: () => amount,
    );
    return AlertDialog(
      title: const Text("Calculadora Rápida"),
      content: ListTile(
        dense: true,
        title: const Text("Resultado"),
        subtitle: TextField(
          keyboardType: TextInputType.number,
          /* inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r"^[0-9]*\.?[0-9]*$")),
          ], */

          decoration: InputDecoration(
            errorText: isInvalid ? "Monto inválido" : null,
            helperText:
                !isInvalid ? "${calculatedAmount.toStringAsFixed(2)}bs" : null,
          ),
          autofocus: true,
          onChanged: (String value) {
            setState(() {
              textFieldValue = value;
            });
          },
        ),
      ),
      actions: [
        FilledButton(
            onPressed: () {
              copy("${calculatedAmount.toStringAsFixed(2)}bs");
              ToastMessage.success(title: const Text("Monto copiado"));
            },
            child: const Text("Copiar"))
      ],
    );
  }
}
