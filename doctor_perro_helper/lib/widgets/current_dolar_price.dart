import 'package:doctor_perro_helper/config/border_size.dart';
import 'package:doctor_perro_helper/models/consumers/dolar_price_text.dart';
import 'package:doctor_perro_helper/utils/copy_clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toastification/toastification.dart';

class CurrentDolarPrice extends StatelessWidget {
  const CurrentDolarPrice({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.all(Sizes().xxl),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Sizes().roundedSmall),
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  DolarPriceText(
                    style: TextStyle(
                      fontSize: 60.0,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const Text(
                    "Bs",
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ],
              ),
              Text(
                "Precio del dolar",
                style: TextStyle(
                  fontSize: 12.0,
                  color: Theme.of(context).colorScheme.onSurface.withAlpha(170),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: Sizes().medium,
          left: Sizes().medium,
          child: Icon(
            Icons.calculate,
            size: Sizes().xxxl,
            color: Theme.of(context).colorScheme.onSurface.withAlpha(100),
          ),
        ),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              splashColor:
                  Theme.of(context).colorScheme.onSurfaceVariant.withAlpha(70),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) =>
                      const PriceCalculatorDialog(),
                );
              },
              borderRadius: BorderRadius.circular(Sizes().roundedSmall),
            ),
          ),
        ),
      ],
    );
  }
}

class PriceCalculatorDialog extends StatefulWidget {
  const PriceCalculatorDialog({
    super.key,
  });
  // fetch the price in the config, when we have it, for now:
  final double dolarPrice = 60.0;

  @override
  State<PriceCalculatorDialog> createState() => _PriceCalculatorDialogState();
}

class _PriceCalculatorDialogState extends State<PriceCalculatorDialog> {
  String fieldValue = "0";
  bool isInvalid = true;

  double amount = 0.0;

  double calculatedAmount() => amount * widget.dolarPrice;

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
            helperText: !isInvalid
                ? "${(calculatedAmount()).toStringAsFixed(2)}bs"
                : null,
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
        TextButton(
            onPressed: () {
              copy("${(calculatedAmount()).toStringAsFixed(2)}bs");

              toastification.show(
                title: const Text("Monto copiado"),
                autoCloseDuration: const Duration(seconds: 2),
                type: ToastificationType.success,
                style: ToastificationStyle.fillColored,
                primaryColor: Theme.of(context).colorScheme.secondary,
                foregroundColor: Theme.of(context).colorScheme.onSecondary,
                showProgressBar: false,
              );
            },
            child: const Text("Copiar"))
      ],
    );
  }
}
