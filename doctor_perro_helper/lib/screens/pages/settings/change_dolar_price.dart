import 'package:flutter/material.dart';

class ChangeDolarPrice extends StatelessWidget {
  const ChangeDolarPrice({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("El dolar vale:"),
      content: const TextField(
        autofocus: true,
        keyboardType: TextInputType.number,
      ),
      actions: [
        TextButton(
          onPressed: () {},
          child: const Text("Aceptar"),
        )
      ],
    );
  }
}
