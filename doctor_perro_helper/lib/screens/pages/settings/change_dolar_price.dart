import 'package:doctor_perro_helper/models/providers/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChangeDolarPrice extends StatelessWidget {
  const ChangeDolarPrice({super.key});
  /*  String validateValue(String expression, String defaultValue) {
    if (!isValidCommaExpression(expression)) {
      return defaultValue;
    }
    return expression;
  } */

  // late double dolarPrice = 0.0;

  /* late SharedPreferences prefs;

  Future<void> getPrefs() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    if (!_prefs.containsKey("dolar_price")) {
      _prefs.setDouble("dolar_price", 60.0);
      return;
    }

    setState(() {
      prefs = _prefs;
      dolarPrice = _prefs.getDouble("dolar_price") ?? 0.0;
    });
  }

  @override
  void initState() {
    super.initState();
    getPrefs();
  } */
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
  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: true,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          suffixText: "${ref.watch(dolarPriceNotifierProvider)}bs"),
      onSubmitted: (String value) {
        double parsed = double.tryParse(value) ?? 0.0;
        ref.read(dolarPriceNotifierProvider.notifier).changePrice(parsed);
        Navigator.pop(context);
      },
      /* onChanged: (String value) {
          double parsed = double.parse(value);
          settings.changeDolarPrice(parsed);
          setState(() {
            dolarPrice = parsed;
          });
        }, */
    );
  }
}
